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
#' @importFrom tools file_path_sans_ext
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
      # Use PowerShell to create shortcut
      ps_command <- sprintf(
        '$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut("%s"); $Shortcut.TargetPath = "%s"; $Shortcut.Save()',
        gsub("/", "\\\\", shortcut_path),
        gsub("/", "\\\\", file_server_path)
      )

      result <- system2("powershell", args = c("-Command", shQuote(ps_command, type = "cmd")),
                        stdout = TRUE, stderr = TRUE)

      if (file.exists(shortcut_path)) {
        message("Created shortcut to file server at: ", shortcut_path)
        return(invisible(TRUE))
      } else {
        warning("Shortcut creation may have failed. File not found at: ", shortcut_path)
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
