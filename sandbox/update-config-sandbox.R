rm(list=ls(all.names=TRUE))
library(magrittr)

# Run this line to update to the newest config file:
# utils::download.file(
#   url       = "https://github.com/OuhscBbmc/cdw-skeleton-1/blob/master/config.yml?raw=true",
#   destfile  = "./inst/tests/config.yml"
# )

path_in    <- system.file("tests/config.yml", package = "pluripotent")
path_out  <- "inst/tests/config-out-expected.yml"
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
  gsub(pattern = "\\{directory_output\\}"     , replacement = config$directory_output     , x = rlang::.data) %>%
  gsub(pattern = "\\{directory_file_server\\}", replacement = config$directory_file_server, x = rlang::.data) %>%
  gsub(pattern = "\\{project_name\\}"         , replacement = project_name                , x = rlang::.data) %>%
  gsub(pattern = "\\{schema_name\\}"          , replacement = gsub("-", "_", project_name), x = rlang::.data) #%>%
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
