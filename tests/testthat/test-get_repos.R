context("test-get_repos.R")

test_that("get_repos works", {
  expect_is(get_repos("ropenscilabs"), "data.frame")
})
