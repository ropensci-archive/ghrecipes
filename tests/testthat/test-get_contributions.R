context("test-get_contributions.R")

test_that("get_contributions works", {
  expect_is(get_contributions(), "data.frame")
})
