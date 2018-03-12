
#' get table of issues ordered by number of thumbs up
#'
#' @inheritParams get_contents
#' @param  no_null Boolean, whether to not return issues with no thumb up
#'
#' @return a tibble
#' @export
#'
#' @examples
#' get_issues_thumbs("tidyverse", "dplyr")
get_issues_thumbs <- function(owner, repo, no_null = TRUE){
  query <- paste0('{
  repository(owner: "',owner,'", name: "',repo,'") {
                      issues(first: 100, states:OPEN, after: %s) {
                      edges {
                  node {
                  number
                  title
                  url
                  labels(first:100){
                  edges{
                  node{
                  name
                  }
                  }
                  }
                  milestone{
                  number
                  description
                  }
                  bodyText
                  createdAt
                  assignees(first:100){
                  edges{
                  node{
                  login
                  }
                  }
                  }
                  author{
                  login
                  }
                  reactions(content: THUMBS_UP) {
                  totalCount
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

  output <- res %>%
    jqr::jq(".data.repository.issues.edges[].node") %>%
    jqr::jq("{number: .number,
            created_at: .createdAt,
            title: .title,
            author: .author.login,
            thumbs_up_no: .reactions.totalCount,
            body: .bodyText,
            labels: [.labels.edges[].node.name?]|add,
            url: .url,
            milestone_no: .milestone.number?,
            milestone_desc: .milestone.description?}")  %>%
    jqr::combine() %>% # single json file
    jsonlite::fromJSON() %>%
    tibble::as_tibble() %>%
    dplyr::mutate(created_at = anytime::anytime(created_at),
                  owner = owner,
                  repo = repo,
                  body = stringr::str_sub(body, 1, 300)) %>%
    dplyr::arrange(- thumbs_up_no)

  if(no_null){
    dplyr::filter(output, (!!rlang::sym("thumbs_up_no") > 0))
  }
  }

