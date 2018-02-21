context("test-get_contents.R")

test_that("get_contents works", {
  expect_is(get_contents("maelle", "convertagd"), "character")
})
