#' @name start_project
#' @aliases start_r_analysis_skeleton start_cdw_skeleton_1
#'
#'
#' @title Start specific projects
#'
#' @description `start_r_analysis_skeleton()` copies the files
#' to the `destination_directory` on your local maachine.
#'
#' @param project_name [character] of the new project.  Defaults to `new-project`.
#' @param destination_directory [character] of the files.  Defaults to `~` (*i.e*, the home directory).
#'
#'
#' @usage
#' start_r_analysis_skeleton(
#'   project_name  = "new-project-analysis",
#'   destination_directory = "~/analysis"
#' )
#' start_cdw_skeleton_1(
#'   project_name  = "new-project-cdw",
#'   destination_directory = "~/cdw"
#' )
#'
#' @details
#' Currently, two types of project is supported:
#' 1. r-analysis-skeleton
#' 1. cdw-sekeleton-1
#'
#' @note
#' To view the files involved in each project type,
#' refer to https://github.com/OuhscBbmc/pluripotent/inst/data/file-to-copy.csv.
#' Each line represents one file that will be placed in the new project.  The columns are
#' 1. `offspring`: the project type to be created.
#' 1. `destination`: the file's location in the new project.
#' 1. `source`: the location where the file is copied from.
#'
#' @importFrom magrittr %>%
#' @importFrom rlang .data
#' @importFrom utils download.file
#'
#' @author Will Beasley
#'
#' @examples
#' library(pluripotent)
#'
#' \dontrun{
#' start_r_analysis_skeleton("new-project", "./data-public/testing")
#' start_cdw_skeleton_1()
#' start_cdw_skeleton_1("thumann-awesomeness-4")
#' }

#' @export
start_r_analysis_skeleton <- function(
  project_name              = "new-project-analysis",
  destination_directory     = "~/analysis"
) {

  start_skeleton(
    offspring_type        = "r-analysis-skeleton",
    project_name          = project_name,
    destination_directory = destination_directory
  )

}

#' @export
start_cdw_skeleton_1 <- function(
  project_name              = "new-project-cdw",
  destination_directory     = "~/cdw"
) {

  start_skeleton(
    offspring_type        = "cdw-skeleton-1",
    project_name          = project_name,
    destination_directory = destination_directory
  )

}

start_skeleton <- function(
  offspring_type,
  project_name,
  destination_directory     = "~"
) {
  destination_directory_full <- file.path(destination_directory, project_name)

  d <- retrieve_file_list(
    offspring             = offspring_type,
    project_name          = project_name,
    destination_directory = destination_directory_full
  )

  directories     <- sort(unique(dirname(d$destination)))

  directories[!dir.exists(directories)] %>%
    purrr::walk(~dir.create(., recursive = T))

  #   browser()

  purrr::walk2(.x=d$source, .y=d$destination, .f=~utils::download.file(url=.x, destfile=.y))
}
