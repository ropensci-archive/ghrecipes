#' Get collaborators of a repository
#'
#' @inheritParams get_contents
#'
#' @return a data.frame of collaborators name, login and rights
#' @export
#'
#' @examples
#' \dontrun{
#' get_collaborators("ropensci", "ropenaq")
#' }
get_collaborators <- function(owner, repo){
  query <- paste0('{
                  repository(owner: "', owner, '", name: "', repo,'") {
                  collaborators(first: 100, affiliation: ALL, after: %s) {
      edges {
                  permission
                  node {
                  login
                  name
                  }
                  cursor
}
pageInfo {
hasNextPage
}
}
}
}
')
  res <- iterate(query)
  collaborators <- jqr::jq(res, ".data.repository.collaborators.edges[]") %>%
    jqr::jq("{name: .node.name,
            login: .node.login,
            permission: .permission}") %>%
    jqr::combine() %>%
    jsonlite::fromJSON() %>%
    tibble::as_tibble()
  collaborators$repo <- repo
  collaborators$owner <- owner
  collaborators

}
