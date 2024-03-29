#' @name retrieve_file_list
#' @aliases retrieve_file_list download_file_list
#'
#'
#' @title Retrieve and download files for a project
#'
#' @description `retrieve_file_list()` retrieve the complete list
#' of files to be copied into a new project, while
#' `download_file_list()` copies the files to the `destination_directory`
#' on your local maachine.
#'
#' @param offspring [character] of observed values in the investigation. Required.
#' @param project_name [character] of the new project.  Defaults to `new-project`.
#' @param destination_directory [character] of the files.  Defaults to `~` (*i.e*, the home directory).
#'
#' @return Table of files to copy
#'
#' @usage
#' retrieve_file_list(
#'   offspring,
#'   project_name = "new-project",
#'   destination_directory = file.path("~", project_name)
#' )
#' download_file_list(
#'   offspring,
#'   project_name  = "new-project",
#'   destination_directory = file.path("~", project_name)
#' )
#'
#' @details
#' Currently, three types of projects are supported:
#' 1. r-analysis-skeleton
#' 1. cdw-skeleton-1
#' 1. neonatology-1
#'
#' @note
#' To view the files involved in each project type,
#' refer to https://github.com/OuhscBbmc/pluripotent/inst/data/file-to-copy.csv.
#' Each line represents one file that will be placed in the new project.  The columns are
#' 1. `offspring`: the project type to be created.
#' 1. `copy`: indicator if the file should be copied.  If `FALSE`, the file is ignored.
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
#' d1 <- retrieve_file_list("r-analysis-skeleton")
#'
#' \dontrun{
#' download_file_list("r-analysis-skeleton", "new-project", "./data-public/testing")
#' }

#' @export
download_file_list <- function(
  offspring,
  project_name              = "new-project",
  destination_directory     = file.path("~", project_name)
) {
  d <- retrieve_file_list(
    offspring,
    project_name            = project_name,
    destination_directory   = destination_directory
  )

  # Sort so the correct nesting structure is represented.
  #   This avoid the warning about creating an existing directory.
  directories     <- sort(unique(dirname(d$destination)))

  directories[!dir.exists(directories)] %>%
    purrr::walk(~dir.create(., recursive = T))
  # for( directory in directories ) {
  #   if( !dir.exists(directories) )
  #     dir.create(directory, recursive=T)
  # }

  purrr::walk2(.x=d$source, .y=d$destination, .f=~utils::download.file(url=.x, destfile=.y))
  # mapply(function(x, y) download.file(x,y, mode="wb"),x = d$source, y = d$destination)
  # utils::download.file(d$source, d$destination)
}

#' @importFrom rlang .data
#' @export
retrieve_file_list <- function(
  offspring,
  project_name = "new-project",
  destination_directory     = file.path("~", project_name)
) {

  levels_offspring <- c(
    "r-analysis-skeleton",
    "cdw-skeleton-1",
    "neonatology-1"
  )
  checkmate::assert_character( offspring          , any.missing=F, min.chars=1, len=1)
  checkmate::assert_subset(    offspring          , levels_offspring, empty.ok = F)

  col_types <- readr::cols_only(
    offspring               = readr::col_character(),
    copy                    = readr::col_logical(),
    destination_template    = readr::col_character(),
    destination_relative    = readr::col_logical(),
    source                  = readr::col_character()
  )
  d <- system.file("metadata", "file-to-copy.csv", package = "pluripotent", mustWork = TRUE) %>%
    readr::read_csv(col_types=col_types) %>%
    dplyr::filter(.data$copy)

  checkmate::assert_tibble(
    d,
    min.rows      = 1,
    any.missing   = F,
    types = c("character", "character", "logical", "character"),
    col.names = "strict"
  )

  d %>%
    dplyr::filter(.data$offspring == !!offspring) %>%
    dplyr::mutate(
      destination   = gsub("\\{project-name\\}", project_name, .data$destination_template),
      destination   = dplyr::if_else(.data$destination_relative, file.path(destination_directory, .data$destination), .data$destination)
      # destination   = dplyr::if_else(.data$destination_relative, path.expand(.data$destination), .data$destination)
    ) %>%
    dplyr::select(.data$destination, .data$destination_template, .data$source)
}
