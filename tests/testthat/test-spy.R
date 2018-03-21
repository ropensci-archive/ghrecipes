context("test-spy.R")

test_that("is_package works", {
  expect_is(spy("lintr-bot", type = "PullRequest"), "data.frame")
})
