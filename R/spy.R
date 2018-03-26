#' Get latest issues where an user commented
#'
#' @param user username
#' @param type "Issue" or "PullRequest"
#'
#' @return tibble
#' @export
#'
#' @examples
#' # https://github.com/lintr-bot
#' spy("lintr-bot")
spy <- function(user, type = "Issue",
                updated_after = as.character(Sys.Date() - 10),
                updated_before = as.character(Sys.Date())){
  query <- paste0('{
  search(query: "commenter:',user, ' updated:',
  updated_after,'..',updated_before,'", type: ISSUE, first: 100, after: %s) {
    edges {
                  node {
                  ... on ',type,' {
                  number
                  state
                  title
                  author {
                  login
                  }
                  createdAt
                  comments {
                  totalCount
                  }
                  repository {
                  nameWithOwner
                  }
                  url
                  }
                  }
cursor
                  }
                  pageInfo {
                  hasNextPage
                  }

}
}
')

  output <- iterate(query) %>%
    jqr::jq(".data.search.edges[].node|select(.!={})")

  if(length(as.character(output)) == 0){
    return(NULL)
  }else{
    output <- output %>%
      jqr::jq("{repo: .repository.nameWithOwner,
              title: .title,
              created_at: .createdAt,
              state: .state,
              author: .author.login,
              url: .url,
              no_comments: .comments.totalCount,
              id: .number}")%>%
      jqr::combine() %>% #
      jsonlite::fromJSON() %>%
      dplyr::as_data_frame() %>%
      dplyr::mutate(created_at = anytime::anytime(.data$created_at)) %>%
      dplyr::mutate(url = glue::glue("<a href='{url}'>{url}</a>"))
  }

  output <- tidyr::separate(output, repo, sep="/", into = c("owner", "repo"))
  output <- unique(output)
  if(type == "Issue"){
    info <- unique(output[, c("owner", "repo", "id", "url")])
    threads <- purrr::pmap_df(list(info$owner, info$repo, info$id),
                              get_issue_thread)
    threads <- threads[threads$author == user,]
    output <- dplyr::left_join(info, threads, by = c("repo", "owner",
                                                       "id" = "issue"))
  }
  output

}
