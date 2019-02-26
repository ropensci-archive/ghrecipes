#' Get contributions by a given account
#'
#' @inheritParams get_repos
#'
#' @return tibble with name (owner/repo), description, primary language, stargazer count, is_fork, is_privatem, and is_created.
#' @export
#'
#' @examples \dontrun{
#' cb <- get_contributions()
#' }
get_contributions <- function(privacy = "PUBLIC"){
  if(all(c("PRIVATE", "PUBLIC") %in% privacy)){
    privacy <- "null"
  }
  if(!(privacy %in% c("PRIVATE", "PUBLIC", "null"))){
    stop(paste0("privacy must be one of: PRIVATE, PUBLIC, null"))
  }
  query <- paste0('{
  viewer {
    repositoriesContributedTo(first: 100, privacy: ', privacy, ', contributionTypes: [COMMIT, REPOSITORY]) {
      nodes {
        nameWithOwner
        description
        isFork
        isArchived
        isPrivate
        primaryLanguage {
          name
          color
        }
        stargazers {
          totalCount
        }
      }
      pageInfo {
        hasNextPage
      }
    }
  }
 }')
  iterate(query) %>%
    jqr::jq(".data.viewer.repositoriesContributedTo.nodes[]") %>%
    jqr::jq("{name: .nameWithOwner,
            description: .description,
            language: .primaryLanguage,
            stargazers_count: .stargazers,
            is_fork: .isFork,
            is_private: .isPrivate,
            is_archived: .isArchived}")  %>%
    jqr::combine() %>% # single json file
    jsonlite::fromJSON() %>%
    tibble::as_tibble() %>%
    dplyr::mutate(name = stringr::str_replace_all(.data$name, '\\\"', ''))
}
