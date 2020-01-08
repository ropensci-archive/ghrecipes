#' Get teams of an organisation
#'
#' @inheritParams get_repos
#'
#' @return a data.frame of teams info, repositories names
#' and member logins as nested data.frames.
#' @export
#'
#' @examples
#' \dontrun{
#' get_teams("ropensci")
#' }
get_teams <- function(owner){
  query <- paste0('{
                  organization(login: "', owner,'") {
                  teams(first: 100 %s) {
                   edges {
        node {
                  name
                  members(first:100){
            nodes{
                  login
}
}
                  repositories(first:100){
                  nodes{
                  name
                  }
                  }
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
  collaborators <- jqr::jq(res, ".data.organization.teams.edges[].node") %>%
    jqr::jq("{name: .name,
            members: .members[],
            repos: .repositories[]}") %>%
    jqr::combine() %>%
    jsonlite::fromJSON() %>%
    tibble::as_tibble()
  collaborators$owner <- owner
  collaborators

  }
