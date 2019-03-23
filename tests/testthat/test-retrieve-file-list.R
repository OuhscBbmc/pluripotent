library(testthat)
context("retrieve file list")


test_that("Smoke Test", {
  d <- retrieve_file_list("r-analysis-skeleton")
  expect_true(!is.null(d))
})

test_that("Smoke Test", {
  d <- retrieve_file_list("r-analysis-skeleton")
  expect_equal(nrow(d), 2L)
})
