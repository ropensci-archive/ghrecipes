context("test-get_issues_labels_state.R")

test_that("get_issues_labels_state works", {
  expect_is(get_issue_labels_state("ropensci", "taxize"), "data.frame")
})
