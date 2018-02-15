#' Get repositories of one owner
#'
#' @param owner string
#'
#' @return string of repos, format org/repo_name
#' @export
#'
#' @examples
#' get_repos("jeroen")
get_repos <- function(owner){
  token <- Sys.getenv("GITHUB_GRAPHQL_TOKEN")
  cli <- ghql::GraphqlClient$new(
    url = "https://api.github.com/graphql",
    headers = httr::add_headers(Authorization = paste0("Bearer ", token))
  )
  cli$load_schema()
  query <- paste0('query{
                  repositoryOwner(login: "', owner, '"){
                  repositories(first:100, after: %s){
                  nodes {
                  nameWithOwner
                  }
                  edges{
                  cursor
                  }
                  pageInfo {
                  hasNextPage
                  }
                  }
                  }
}')
  iterate(query) %>%
    jqr::jq("..|.nameWithOwner?|select(.!=null)") %>%
    stringr::str_replace_all('\\\"', '')
  }
