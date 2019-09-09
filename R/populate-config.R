#' @name populate_config
#'
#' @title Populated the configuration value with project-specific values.
#'
#' @description `populate_config()` starts with config file and replaces the
#' template values with project-specific values.
#'
#' @param path_in [character] of the config file to populate.  Required.
#' @param project_name [character] of the new project.  Required.
#' @param path_out [character] of the config file to populate.  Required.
#'
#' @importFrom magrittr %>%
#'
#' @author Will Beasley
#'
#' @examples
#' library(pluripotent)
#'
#' \dontrun{
#' url_config <- "https://github.com/OuhscBbmc/cdw-skeleton-1/blob/master/config.yml?raw=true"
#' path_in    <- "~/config.yml"
#' path_out   <- "~/config-out.yml"
#' utils::download.file(url=url_config, destfile=path_in)
#' populate_config(
#'   path_in        = path_in,
#'   project_name   = "thumann-awesomeness-1",
#'   path_out       = path_out
#' )
#' }

#' @export
populate_config <- function( path_in, project_name, path_out = path_in ) {

  template  <- readr::read_file(path_in)
  config    <- config::get(file=path_in)

  value <-
    template %>%
    gsub("\\{directory_output\\}", config$directory_output, .) %>%
    gsub("\\{directory_file_server\\}", config$directory_file_server, .) %>%
    gsub("\\{project_name\\}", project_name, .) %>%
    gsub("\\{schema_name\\}", gsub("-", "_", project_name), .)

  readr::write_file(value, path_out)
}
