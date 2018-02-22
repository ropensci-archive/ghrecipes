context("get_description")

test_that("get_description works", {
  expect_is(get_description("ropensci", "ropenaq"), "data.frame")
})

test_that("get_description checks whether it's a pkg", {
  expect_error(get_description("ropensci", "unconf17"), "not a package")
})
