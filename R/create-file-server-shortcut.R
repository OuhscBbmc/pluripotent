#' Create a shortcut to the file server directory
#'
#' Creates a Windows shortcut (.lnk file) or symbolic link (on Unix-like systems)
#' to the project's file server directory.
#'
#' @param project_directory [character] Path to the local project directory. Required.
#' @param file_server_path [character] Path to the file server location. Required.
#'
#' @return Invisibly returns TRUE if successful, FALSE otherwise.
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' create_file_server_shortcut(
#'   project_directory = "~/my-project",
#'   file_server_path = "//pedsis/peds/data/BBMC/prairie-outpost/my-project"
#' )
#' }

create_file_server_shortcut <- function(project_directory, file_server_path) {

  checkmate::assert_directory_exists(project_directory)
  checkmate::assert_character(file_server_path, min.chars = 1, len = 1)

  tryCatch({
    # Check if running on Windows
    if (.Platform$OS.type == "windows") {

      # Delete any existing shortcut first
      shortcut_path <- file.path(project_directory, "File Server Data.lnk")
      if (file.exists(shortcut_path)) {
        unlink(shortcut_path)
      }

      # Create a temporary VBScript file
      vbs_script <- tempfile(fileext = ".vbs")

      # Normalize paths for Windows
      # Use normalizePath for the shortcut location (must exist)
      shortcut_path_win <- normalizePath(project_directory, winslash = "\\", mustWork = TRUE)
      shortcut_path_win <- file.path(shortcut_path_win, "File Server Data.lnk")

      # Convert forward slashes to backslashes for UNC path
      file_server_path_win <- gsub("/", "\\\\", file_server_path)

      # VBScript code to create shortcut
      # Note: Using cat() to show the actual VBScript for debugging
      vbs_code <- sprintf(
        'Set WshShell = WScript.CreateObject("WScript.Shell")
Set oShellLink = WshShell.CreateShortcut("%s")
oShellLink.TargetPath = "%s"
oShellLink.WindowStyle = 1
oShellLink.Description = "Project File Server Location"
oShellLink.WorkingDirectory = "%s"
oShellLink.Save
',
        shortcut_path_win,
        file_server_path_win,
        file_server_path_win
      )

      # Write VBScript to temp file with UTF-8 encoding
      con <- file(vbs_script, "w", encoding = "UTF-8")
      writeLines(vbs_code, con)
      close(con)

      message("Executing VBScript to create shortcut...")
      message("Target: ", file_server_path_win)

      # Execute VBScript with full path to cscript
      result <- system2(
        command = "cscript",
        args = c("//nologo", normalizePath(vbs_script, winslash = "\\")),
        stdout = TRUE,
        stderr = TRUE,
        wait = TRUE
      )

      # Give it a moment
      Sys.sleep(0.5)

      # Clean up VBScript file
      unlink(vbs_script)

      # Check if shortcut was created
      if (file.exists(shortcut_path)) {
        # Verify it's actually a shortcut file (should be binary and small)
        file_info <- file.info(shortcut_path)
        if (file_info$size > 0 && file_info$size < 10000) {
          message("✓ Created shortcut to file server at: ", shortcut_path)
          return(invisible(TRUE))
        } else {
          warning("Shortcut file was created but may be invalid (unusual size: ", file_info$size, " bytes)")
          return(invisible(FALSE))
        }
      } else {
        warning("Shortcut creation failed. File not found at: ", shortcut_path)
        if (length(result) > 0) {
          warning("VBScript output: ", paste(result, collapse = "\n"))
        }
        return(invisible(FALSE))
      }

    } else {
      # On non-Windows systems, create a symbolic link instead
      symlink_path <- file.path(project_directory, "File Server Data")

      if (file.exists(symlink_path)) {
        message("Symlink already exists at: ", symlink_path)
        return(invisible(FALSE))
      }

      file.symlink(file_server_path, symlink_path)
      message("✓ Created symbolic link to file server at: ", symlink_path)
      return(invisible(TRUE))
    }
  }, error = function(e) {
    warning("Failed to create shortcut: ", e$message)
    return(invisible(FALSE))
  })
}
