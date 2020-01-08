
#' get authors of issues in a repo
#'
#' @inheritParams get_contents
#'
#' @return a character vector of all logins of authors of issues
#' @export
#'
#' @examples
#' get_issue_authors("ropensci", "taxize")
get_issue_authors <- function(owner, repo){
  query <- paste0('{
                  repository(owner: "', owner, '", name: "', repo,'") {
                  issues(first: 100 %s) {
                  edges {
                  node {
                  number
                  author {
                  login
                  }
                  }
                  cursor
                  }
                  pageInfo {
                  hasNextPage
                  }
                  }
                  }
}')
  res <- iterate(query)
  authors <- jqr::jq(res, "..|.author?|select(.!=null).login")
  authors <- gsub('\\\"', '', authors)
  unique(authors)
}

