library(testthat)


# Run this line to update to the newest config file:
# utils::download.file(
#   url       = "https://github.com/OuhscBbmc/cdw-skeleton-1/blob/master/config.yml?raw=true",
#   destfile  = "./inst/tests/config.yml"
# )

path_in           <- system.file("tests/config.yml", package = "pluripotent")
path_out_expected <- system.file("tests/config-out-expected.yml", package = "pluripotent")
path_out_actual   <- "testing/config-out-expected.yml"

test_that("Smoke Test -populate_config", {
  populate_config(
    path_in        = path_in,
    project_name   = "thumann-awesomeness-1",
    path_out       = path_out_actual
  )
})
test_that("compare -populate_config", {
  populate_config(
    path_in        = path_in,
    project_name   = "thumann-awesomeness-1",
    path_out       = path_out_actual
  )

  expected  <- readr::read_file(path_out_expected)
  actual    <- readr::read_file(path_out_actual)

  expect_equal(actual, expected)
})
