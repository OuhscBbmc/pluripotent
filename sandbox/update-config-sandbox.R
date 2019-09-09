rm(list=ls(all.names=TRUE))

path_in   <- "/home/wibeasley/Documents/OuhscBbmc/cdw/cdw-skeleton-1/config.yml"
path_out  <- "testing/new-project-cdw/config-out.yml"
template  <- readr::read_file(path_in)
# config <- config::get(file=path_in)

project_name  <- "thumann-awesomeness-1"
# schema_name   <- gsub("-", "_", project_name)
value <-
  glue::glue(
    paste0(template, "\n"),
    project_name            = project_name,
    schema_name             = gsub("-", "_", project_name),
    path_directory          = "{path_directory}",
    path_directory_output   = "{path_directory_output}"
  )

readr::write_file(value, path_out)
# yaml::write_yaml(s, path_out)

config <- config::get(file=path_out)
config$project_name
glue::glue(config$path_directory, .envir = config)
glue::glue(config$path_directory_output, .envir = config)
glue::glue(config$path_output_summary, .envir = config)

config$path_directory_output
# file.path(config$path_directory_output, "
file.path(config$path_directory_output, "data-public/sweep-and-specify-centricity/input/review-required/diagnosis")
