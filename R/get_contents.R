#' Get contents of a repo
#' @importFrom magrittr "%>%"
#' @importFrom rlang .data
#'
#' @param owner owner of the repo, string
#' @param repo repo name, string
#'
#' @return a character vector of the top-level contents of the repo.
#' @details thanks to https://gist.github.com/jonathansick/8bbe88a85addaeeea4e7fe9ef15b016b
#' @export
#'
get_contents <- function(owner, repo){
  query <- paste0('query{
                  repository(owner: "', owner, '", name:"', repo,'"){
                  ref(qualifiedName: "master") {
                  target {
                  ... on Commit {
                  id
                  history(first: 1) {
                  edges {
                  node {
                  tree{
                  entries {
                  name
                  }
                  }
                  }
                  }
                  }
                  }
                  }
                  }
                  }
}
')
  qry <- ghql::Query$new()
  qry$query('foobar', query)
  create_client()$exec(qry$queries$foobar) %>%
    jqr::jq("..|.entries?|select(.!=null)|.[].name") %>%
    as.character() %>%
    stringr::str_replace_all('\\\"', '')
  }
