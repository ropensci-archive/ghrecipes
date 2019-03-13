#' Get repos contributed to by a given account
#'
#' @inheritParams get_repos
#' @inheritParams spy
#'
#' @return tibble with name (owner/repo), description, primary language, stargazer count, is_fork, is_private, and is_created.
#' @export
#'
#' @examples \dontrun{
#' cb <- get_repos_contributed("jsta")
#' }
get_repos_contributed <- function(user, privacy = "PUBLIC"){
  if(all(c("PRIVATE", "PUBLIC") %in% privacy)){
    privacy <- "null"
  }
  if(!(privacy %in% c("PRIVATE", "PUBLIC", "null"))){
    stop(paste0("privacy must be one of: PRIVATE, PUBLIC, null"))
  }
  query <- paste0('{
  user(login:', user,  ') {
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

  parse_response <- function(response){
    jqr::jq(response, "{name: .nameWithOwner,
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

  iterate(query) %>%
    jqr::jq(".data.user.repositoriesContributedTo.nodes[]") %>%
    {`if`(length(.) == 0,
         message("No contributed repos found..."),
         parse_response(.))}
}
