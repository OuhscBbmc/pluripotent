rm(list=ls(all.names=TRUE))
library(magrittr)

# Run this line to update to the newest config file:
# utils::download.file(
#   url       = "https://github.com/OuhscBbmc/cdw-skeleton-1/blob/master/config.yml?raw=true",
#   destfile  = "./inst/tests/config.yml"
# )

path_in    <- system.file("tests/config.yml", package = "pluripotent")
path_out  <- "testing/new-project-cdw/config-out.yml"
template  <- readr::read_file(path_in)
config <- config::get(file=path_in)

project_name  <- "thumann-awesomeness-1"
# schema_name   <- gsub("-", "_", project_name)
config$project_name
config$directory_file_server
config$directory_output
# value <-
#   glue::glue(
#     paste0(template, "\n"),
#     project_name            = project_name,
#     schema_name             = gsub("-", "_", project_name),
#     directory_file_server   = "{directory_file_server}",
#     directory_output        = "{directory_output}"
#   )
# cat(value)

# a <- yaml::yaml.load(value)
# a$default$project_name
# config::get(
#
# )
value <-
  template %>%
  # substr(1,2000) %>%
  gsub("\\{directory_output\\}", config$directory_output, .) %>%
  gsub("\\{directory_file_server\\}", config$directory_file_server, .) %>%
  gsub("\\{project_name\\}", project_name, .) %>%
  gsub("\\{schema_name\\}", gsub("-", "_", project_name), .) #%>%
  # cat()

# %>%
#   glue::glue(
#     directory_file_server   = "{directory_file_server}",
#     directory_output        = "{directory_output}"
#     )


cat(value)

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