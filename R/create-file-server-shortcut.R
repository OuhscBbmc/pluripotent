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

  # Shortcut path in the project directory
  shortcut_path <- file.path(project_directory, "File Server Data.lnk")

  tryCatch({
    # Check if running on Windows
    if (.Platform$OS.type == "windows") {

      # Create a temporary VBScript file
      vbs_script <- tempfile(fileext = ".vbs")

      # Convert forward slashes to backslashes for Windows paths
      shortcut_path_win <- normalizePath(shortcut_path, winslash = "\\", mustWork = FALSE)
      file_server_path_win <- gsub("/", "\\\\", file_server_path)

      # VBScript code to create shortcut
      vbs_code <- sprintf(
        'Set oWS = WScript.CreateObject("WScript.Shell")
Set oLink = oWS.CreateShortcut("%s")
oLink.TargetPath = "%s"
oLink.Description = "Shortcut to project file server directory"
oLink.Save',
        shortcut_path_win,
        file_server_path_win
      )

      # Write VBScript to temp file
      writeLines(vbs_code, vbs_script)

      # Execute VBScript
      result <- system2(
        command = "cscript",
        args = c("//nologo", shQuote(vbs_script)),
        stdout = TRUE,
        stderr = TRUE
      )

      # Clean up VBScript file
      unlink(vbs_script)

      # Check if shortcut was created
      if (file.exists(shortcut_path)) {
        message("Created shortcut to file server at: ", shortcut_path)
        return(invisible(TRUE))
      } else {
        warning("Shortcut creation may have failed. File not found at: ", shortcut_path)
        warning("VBScript output: ", paste(result, collapse = "\n"))
        return(invisible(FALSE))
      }

    } else {
      # On non-Windows systems, create a symbolic link instead
      symlink_path <- file.path(project_directory, "File Server Data")

      if (file.exists(symlink_path)) {
        warning("Symlink already exists at: ", symlink_path)
        return(invisible(FALSE))
      }

      file.symlink(file_server_path, symlink_path)
      message("Created symbolic link to file server at: ", symlink_path)
      return(invisible(TRUE))
    }
  }, error = function(e) {
    warning("Failed to create shortcut: ", e$message)
    return(invisible(FALSE))
  })
}
