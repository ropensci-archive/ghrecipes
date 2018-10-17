context("test-get_token")

test_that("check that correct token is retrieved", {
  mock_sysgetenv <- function(gh_graphql, gh_token, gh_pat) {
    function(x, unset = ""){
      token <- switch(x,
                      "GITHUB_GRAPHQL_TOKEN" = gh_graphql,
                      "GITHUB_TOKEN" = gh_token,
                      "GITHUB_PAT" = gh_pat)
      if(token != "") return(token)
      return(unset)
    }
  }

  with_mock(
    Sys.getenv = mock_sysgetenv("aa", "bb", "cc"),
    expect_equal(get_token(), "aa")
  )

  with_mock(
    Sys.getenv = mock_sysgetenv("", "bb", "cc"),
    expect_equal(get_token(), "bb")
  )

  with_mock(
    Sys.getenv = mock_sysgetenv("", "", "cc"),
    expect_equal(get_token(), "cc")
  )

  with_mock(
    Sys.getenv = mock_sysgetenv("", "", ""),
    expect_error(get_token())
  )
})
