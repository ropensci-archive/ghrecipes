#' Get repositories of one owner
#'
#' @param owner string
#'
#' @return tibble with name (owner/repo), creation time, latest update time,
#' description and is_fork.
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
                  createdAt
                  updatedAt
                  description
                  isFork

                  ref(qualifiedName: "master") {
      target {
                  ... on Commit {
                  history(first: 1) {
                  edges {
                  node {
                  committedDate
                  }
                  }
                  }
                  }
}
}

}
edges{
cursor
}
pageInfo {
hasNextPage
}
}
}
}
')
  iterate(query) %>%
    jqr::jq(".data.repositoryOwner.repositories.nodes[]") %>%
    jqr::jq("{name: .nameWithOwner,
            created_at: .createdAt,
            updated_at: .updatedAt,
            description: .description,
            is_fork: .isFork,
            latest_commit: .ref.target.history.edges[].node.committedDate}")  %>%
    jqr::combine() %>% # single json file
    jsonlite::fromJSON() %>%
    tibble::as_tibble() %>%
    dplyr::mutate(name = stringr::str_replace_all(.data$name, '\\\"', ''),
                  created_at = anytime::anytime(.data$created_at),
                  updated_at = anytime::anytime(.data$updated_at),
                  latest_commit = anytime::anytime(.data$latest_commit))
  }
