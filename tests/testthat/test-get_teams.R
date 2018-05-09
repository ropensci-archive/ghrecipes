context("test-get_teams.R")

test_that("it returns a df", {
  expect_is(get_teams("ropensci"), "data.frame")
})
