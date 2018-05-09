context("test-get_teams.R")

test_that("it returns a df", {
  skip_on_travis()
  expect_is(get_teams("ropensci"), "data.frame")
})
