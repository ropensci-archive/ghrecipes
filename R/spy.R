#' Get latest issues where an user commented
#'
#' @param user username
#' @param type "Issue" or "PullRequest"
#'
#' @return tibble
#' @export
#'
#' @examples
#' https://github.com/lintr-bot
#' spy("lintr-bot")
spy <- function(user, type = "Issue"){
  query <- paste0('{
  search(query: "commenter:',user,'", type: ISSUE, last: 100) {
    edges {
                  node {
                  ... on ',type,' {
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
}

}
}
')

  qry <- ghql::Query$new()
  qry$query('foobar', query)

  output <- create_client()$exec(qry$queries$foobar) %>%
    jqr::jq(".data.search.edges[].node|select(.!={})")

  if(length(as.character(output)) == 0){
    return(NULL)
  }else{
    output %>%
      jqr::jq("{repo: .repository.nameWithOwner,
              title: .title,
              created_at: .createdAt,
              state: .state,
              author: .author.login,
              url: .url,
              no_comments: .comments.totalCount}")%>%
      jqr::combine() %>% #
      jsonlite::fromJSON() %>%
      dplyr::as_data_frame() %>%
      dplyr::mutate(created_at = anytime::anytime(.data$created_at)) %>%
      dplyr::mutate(url = glue::glue("<a href='{url}'>{url}</a>"))
  }

}
