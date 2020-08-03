library(testthat)

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
  expect_gt(nrow(d), 40L)
})
test_that("Retrieve cdw-skeleton", {
  destination <- "./testing"
  d <- retrieve_file_list(
    "cdw-skeleton-1",
    destination_directory = destination
  )
  expect_gt(nrow(d), 23L)
})

test_that("Download", {
  destination <- "./testing"
  download_file_list(
    "r-analysis-skeleton",
    destination_directory = destination
  )

  file_count <- length(list.files(destination, all.files = T, recursive = T))
  expect_gt(file_count, 40L)

  unlink(destination, recursive = TRUE)
})

# test_that("Retrieve", {
#   d <- retrieve_file_list("r-analysis-skeleton")
#   expect_equal(nrow(d), 13L)
# })
