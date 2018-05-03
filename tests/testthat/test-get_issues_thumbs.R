context("test-get_issues_thumbs.R")

test_that("get_issues_thumbs works", {
  expect_is(get_issues_thumbs("ropensci", "taxize"), "data.frame")
})
