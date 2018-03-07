#' Get contents of a file
#'
#' @inheritParams get_description
#' @param path path to the file
#'
#' @return nothing interesting yet
#' @export
#'
#' @details
#' https://platform.github.community/t/query-repo-contents-with-graphql-api/1896
#' @examples
#' library("magrittr")
#' pof <- get_file(owner = "ropensci", repo = "roregistry",
#'          branch = "master", path = "registry.json") %>%
#'          jsonlite::toJSON()
get_file <- function(owner, repo, branch, path){
  query <- paste0('query {
  repository(name: "', repo,'", owner: "', owner,'") {
                  object(expression: "', branch, ':', path, '") {
                  ... on Blob {
                  text
                  }
                  }
}
}')

  qry <- ghql::Query$new()
  qry$query('foobar', query)



  res <- ghql_gh_cli$exec(qry$queries$foobar)
  res %>%
    jqr::jq(".data.repository.object.text")
}
