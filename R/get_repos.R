#' Get repositories of one owner
#'
#' @param owner string
#' @param privacy string, one of "PUBLIC", "PRIVATE", or "null" for both.
#'
#' @return tibble with name (owner/repo), creation time, latest update time,
#' description, is_fork, is_archived, and is_private.
#' @export
#'
#' @examples
#' get_repos("jeroen")
#' get_repos("ropensci")
get_repos <- function(owner, privacy = "PUBLIC"){
  if(all(c("PRIVATE", "PUBLIC") %in% privacy)){
    privacy <- "null"
  }
  if(!(privacy %in% c("PRIVATE", "PUBLIC", "null"))){
    stop(paste0("privacy must be one of: PRIVATE, PUBLIC, null"))
  }
  query <- paste0('query{
                  repositoryOwner(login: "', owner, '"){
                  repositories(first:100, privacy: ', privacy, ', after: %s){
                      nodes {

                  nameWithOwner
                  createdAt
                  updatedAt
                  description
                  primaryLanguage {
                    name
                    color
                  }
                  stargazers {
                    totalCount
                  }
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

  parse_response <- function(response){
    jqr::jq(response, "{name: .nameWithOwner,
              created_at: .createdAt,
              updated_at: .updatedAt,
              description: .description,
              language: .primaryLanguage,
              stargazers_count: .stargazers,
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
  }

  iterate(query) %>%
    jqr::jq(".data.repositoryOwner.repositories.nodes[]") %>%
    {`if`(length(.) == 0,
          message("No repos found..."),
          parse_response(.))}

  }
