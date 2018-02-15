#' Get repositories of one owner
#'
#' @param owner string
#'
#' @return string of repos, format org/repo_name
#' @export
#'
#' @examples
#' get_repos("jeroen")
#' get_repos("ropensci")
get_repos <- function(owner){

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
