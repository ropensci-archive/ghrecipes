context("test-get_collaborators.R")

test_that("it returns a df", {
  skip_on_travis()
  expect_is(get_collaborators("ropensci", "ropenaq"), "data.frame")
})
