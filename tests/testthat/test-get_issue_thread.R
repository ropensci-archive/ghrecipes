context("test-get_issue_thread.R")

test_that("get_issue_thread works", {
  # more than 100 comments
  expect_is(get_issue_thread(owner = "ropensci", repo = "onboarding", issue_id = 1),
            "data.frame")
  expect_is(get_issue_thread("ropensci", "onboarding", 156),
            "data.frame")
  # no label
  expect_is(get_issue_thread("ropensci", "drake", 340),
            "data.frame")
})
