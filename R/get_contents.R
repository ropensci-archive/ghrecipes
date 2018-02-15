#' Get contents of a repo
#' @importFrom magrittr "%>%"
#'
#' @param owner owner of the repo, string
#' @param repo repo name, string
#'
#' @return a character vector of the top-level contents of the repo.
#' @details thanks to https://gist.github.com/jonathansick/8bbe88a85addaeeea4e7fe9ef15b016b
#' @export
#'
#' @examples
#' get_contents("maelle", "convertagd")
get_contents <- function(owner, repo){
  token <- Sys.getenv("GITHUB_GRAPHQL_TOKEN")
  cli <- ghql::GraphqlClient$new(
    url = "https://api.github.com/graphql",
    headers = httr::add_headers(Authorization = paste0("Bearer ", token))
  )
  cli$load_schema()
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

  cli$exec(qry$queries$foobar) %>%
    jqr::jq("..|.entries?|select(.!=null)|.[].name") %>%
    as.character() %>%
    stringr::str_replace_all('\\\"', '')
  }
