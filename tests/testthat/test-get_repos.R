context("test-get_repos.R")

test_that("get_repos works", {
  expect_is(get_repos("ropenscilabs"), "data.frame")
})

test_that("get_repos errors correctly for invalid accounts", {
  expect_error(get_repos("issues"),
        "Invalid query detected. Does the specified owner and/or repo exist?")
})
