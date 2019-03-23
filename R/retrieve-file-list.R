#' @name retrieve_file_list
#'
#' @title Retrieve files for a project
#'
#' @description Retrieve the complete list of files to be copied into a new project.
#'
#' @param offspring [character] of observed values in the investigation. Required.
#' @return Table of files to copy
#'
#' @details
#' Currently, only one type of project is supported:
#' 1. r-analysis-skeleton
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
#'
#' @author Will Beasley
#'
#' @examples
#' library(magrittr)

#' retrieve_file_list("r-analysis-skeleton")

#' @export
retrieve_file_list <- function(
  offspring
) {
  levels_offspring <- c(
    "r-analysis-skeleton"
  )
  checkmate::assert_character( offspring          , any.missing=F, min.chars=1, len=1)
  checkmate::assert_subset(    offspring          , levels_offspring, empty.ok = F)

  col_types <- readr::cols_only(
    offspring     = readr::col_character(),
    destination   = readr::col_character(),
    source        = readr::col_character()
  )
  d <- system.file("metadata", "file-to-copy.csv", package = "pluripotent", mustWork = TRUE) %>%
    # "metadata/file-to-copy.csv" %>%
    readr::read_csv(col_types=col_types)

  checkmate::assert_tibble(d, min.rows = 1)

  d %>%
    dplyr::filter(.data$offspring == offspring)
}
