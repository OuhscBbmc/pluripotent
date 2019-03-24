library(testthat)
context("Start Project")



test_that("start_r_analysis_skeleton", {
  destination <- "./data-public/testing"
  start_r_analysis_skeleton(
    destination_directory = destination
  )

  file_count <- length(list.files(destination, all.files = T, recursive = T))
  expect_equal(file_count, 47L)

  unlink(destination, recursive = TRUE)
})

# test_that("Retrieve", {
#   d <- retrieve_file_list("r-analysis-skeleton")
#   expect_equal(nrow(d), 13L)
# })
