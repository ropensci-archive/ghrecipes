#' Get repositories of one owner
#'
#' @param owner string
#' @param return_private logical, return private repos?
#'
#' @return tibble with name (owner/repo), creation time, latest update time,
#' description, is_fork, is_archived, and is_private.
#' @export
#'
#' @examples
#' get_repos("jeroen")
#' get_repos("ropensci")
get_repos <- function(owner, return_private = FALSE){

  query <- paste0('query{
                  repositoryOwner(login: "', owner, '"){
                  repositories(first:100, after: %s){
                      nodes {

                  nameWithOwner
                  createdAt
                  updatedAt
                  description
                  isFork
                  isArchived
                  isPrivate
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
  res <- iterate(query) %>%
    jqr::jq(".data.repositoryOwner.repositories.nodes[]") %>%
    jqr::jq("{name: .nameWithOwner,
            created_at: .createdAt,
            updated_at: .updatedAt,
            description: .description,
            is_fork: .isFork,
            is_archived: .isArchived,
            is_private: .isPrivate,
            latest_commit: .ref.target.history.edges[].node.committedDate}")  %>%
    jqr::combine() %>% # single json file
    jsonlite::fromJSON() %>%
    tibble::as_tibble() %>%
    dplyr::mutate(name = stringr::str_replace_all(.data$name, '\\\"', ''),
                  created_at = anytime::anytime(.data$created_at),
                  updated_at = anytime::anytime(.data$updated_at),
                  latest_commit = anytime::anytime(.data$latest_commit))
    if(!return_private){
      res <- dplyr::filter(res, !is_private)
    }

  res
  }
