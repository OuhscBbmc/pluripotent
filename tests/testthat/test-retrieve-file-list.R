library(testthat)
context("retrieve file list")


test_that("Smoke Test -Retrieve", {
  d <- retrieve_file_list("r-analysis-skeleton")
  expect_true(!is.null(d))
})

test_that("Retrieve r-analysis-skeleton", {
  destination <- "./testing"
  d <- retrieve_file_list(
    "r-analysis-skeleton",
    destination_directory = destination
  )
  expect_equal(nrow(d), 47L)
})
test_that("Retrieve cdw-skeleton", {
  destination <- "./testing"
  d <- retrieve_file_list(
    "cdw-skeleton-1",
    destination_directory = destination
  )
  expect_equal(nrow(d), 58L)
})

test_that("Download", {
  destination <- "./testing"
  download_file_list(
    "r-analysis-skeleton",
    destination_directory = destination
  )

  file_count <- length(list.files(destination, all.files = T, recursive = T))
  expect_equal(file_count, 48L)

  unlink(destination, recursive = TRUE)
})

# test_that("Retrieve", {
#   d <- retrieve_file_list("r-analysis-skeleton")
#   expect_equal(nrow(d), 13L)
# })
