context("test-get_issue_authors.R")

test_that("collect_issue_authors works", {
  expect_is(get_issue_authors("ropensci", "ropenaq"), "character")
})
