context("test-is_package.R")

test_that("is_package works", {
  expect_true(is_package_repo("maelle", "convertagd"))
})
