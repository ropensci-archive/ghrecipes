#' Table of issues info
#'
#' @inheritParams get_contents
#'
#' @return a tibble of issues info, currently stupidly labels are just concatenated.
#' @export
#'
#' @examples
#' get_issue_labels_state("ropensci", "taxize")
get_issue_labels_state <- function(owner, repo){
  query <- paste0('{
                  repository(owner: "', owner, '", name: "', repo,'") {
                  issues(first: 100, after: %s) {
                  edges {
                  node {
                    number
                  createdAt
                  closedAt
                  title
                  state
                  labels(first: 100){
                  edges{
                  node{
                  name
                  }
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
}')
  res <- iterate(query)

  jqr::jq(res, ".data.repository.issues.edges[].node") %>%
    jqr::jq("{number: .number,
            created_at: .createdAt,
            closed_at: .closedAt,
            title: .title,
            state: .state,
            labels: [.labels.edges[].node.name?]|add}")  %>%
    jqr::combine() %>% # single json file
    jsonlite::fromJSON() %>%
    tibble::as_tibble() %>%
    dplyr::mutate(created_at = anytime::anytime(.data$created_at),
                  closed_at = anytime::anytime(.data$closed_at),
                  owner = owner,
                  repo = repo)
  }

