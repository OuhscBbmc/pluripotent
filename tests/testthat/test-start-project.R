library(testthat)
context("Start Project")

test_that("start_r_analysis_skeleton", {
  destination <- "./testing"
  start_r_analysis_skeleton(
    destination_directory = destination
  )

  file_count <- length(list.files(destination, all.files = T, recursive = T))
  expect_equal(file_count, 47L)

  unlink(destination, recursive = TRUE)
})

test_that("start_cdw_skeleton", {

  # The 'S:/' tests look for an actual mapped drive in Windows/AppVeyor
  #  But Linux/Travis creates a local subdirectory literally called `S:/`
  testthat::skip_on_appveyor()

  destination <- "./testing"
  start_cdw_skeleton_1(
    destination_directory = destination
  )

  file_count <- length(list.files(destination, all.files = T, recursive = T))
  expect_equal(file_count, 42L)

  # There are really 57 files, but 16 go to the S drive,
  #   and I don't know how to capture & test that.

  unlink(destination, recursive = TRUE)

  if( R.version$os=="linux-gnu" ) {
    unlink("./S:"     , recursive = TRUE)
  }
})

# test_that("Retrieve", {
#   d <- retrieve_file_list("r-analysis-skeleton")
#   expect_equal(nrow(d), 13L)
# })
