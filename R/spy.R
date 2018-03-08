#' Get latest issues where an user commented
#'
#' @param user
#'
#' @return tibble
#' @export
#'
#' @examples
#' spy("github")
spy <- function(user){
  query <- paste0('{
  search(query: "commenter:',user,'", type: ISSUE, last: 100) {
                  edges {
                  node {
                  ... on Issue {
                  state
                  title
                  author{
                  login
                  }
                  createdAt
                  comments{
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
}')

  qry <- ghql::Query$new()
  qry$query('foobar', query)

  res <- ghql_gh_cli$exec(qry$queries$foobar)

  res %>%
    jqr::jq(".data.search.edges[].node|select(.!={})") %>%
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
    dplyr::mutate(created_at = anytime::anytime(created_at)) %>%
    dplyr::mutate(url = glue::glue("<a href='{url}'>{url}</a>"))

}
