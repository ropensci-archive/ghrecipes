context("test-get_repos_contributed.R")

test_that("get_repos_contributed works", {
  expect_is(get_repos_contributed("jsta"), "data.frame")
})
