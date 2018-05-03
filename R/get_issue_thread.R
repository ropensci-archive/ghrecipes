#' Get a whole issue thread
#'
#' @inheritParams get_contents
#' @param issue_id issue ID
#'
#' @return A data.frame with one row per comment and
#'  title (of the issue), author, author_association,
#' assignee, created_at (for each comment), closed_at (for the whole issue),
#' body of each comment, comment_url, one column per label, issue.
#' @export
#'
#' @examples
#' get_issue_thread("ropensci", "onboarding", 175)
get_issue_thread <- function(owner, repo, issue_id){
  query <- paste0('{
                             repository(owner: "', owner,'", name: "', repo,'") {
                  issue(number: ', issue_id,') {
                  title
                  authorAssociation
                  assignees(first: 100) {
                  edges {
                  node {
                  login
                  }
                  }
                  }

                  createdAt
                  closedAt
                  labels(first: 100) {
                  edges {
                  node {
                  name
                  }
                  }
                  }
                  author {
                  login
                  }
                  body
                  comments(first: 100, after: %s) {
                  edges {
                  node {
                  body
                  url
                  createdAt
                  author {
                  login
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
}')

  res <- iterate(query)
  res <- res %>%
    jqr::jq('.data.repository.issue')

  # get comments
  comments <- res %>%
    jqr::jq('.comments.edges[].node') %>%
    jqr::jq('{comment_url: .url,
            author: .author.login,
            created_at: .createdAt,
            body: .body}') %>%
    jqr::combine() %>%
    jsonlite::fromJSON() %>%
    dplyr::as_data_frame()

  assignee_no <- res %>%
    jqr::jq('.assignees.edges[].node.login') %>%
    as.character() %>%
    stringr::str_replace_all('\\\"', '') %>%
    unique() %>%
    length()

  # get info about issue
  labels <- jqr::jq(res, '.labels.edges[].node.name?')

  if(assignee_no > 0){
    res <- res %>%
      jqr::jq('{title: .title,
              author_association: .authorAssociation,
              assignee: [.assignees.edges[].node.login?]|add,
              created_at: .createdAt,
              closed_at: .closedAt?,
              body: .body,
              author: .author.login}')
    }else{

      res <- res %>%
        jqr::jq('{title: .title,
                author_association: .authorAssociation,
                created_at: .createdAt,
                closed_at: .closedAt?,
                body: .body,
                author: .author.login}')
      }

  res <- res %>%
    jqr::combine() %>%
    jsonlite::fromJSON() %>%
    # remove NULL elements
    purrr::compact() %>%
    dplyr::as_data_frame()

  # bind to comments and spread label
  if(nrow(res) > 0){
    # easier this way
    if(!"closed_at" %in% names(res)|all(suppressWarnings(is.null(res$closed_at)))){
      res <- dplyr::mutate(res, closed_at = "9999-01-01")
    }

    # empty comment URL
    res <- dplyr::mutate(res, comment_url = "")

    # spread labels
    if(length(as.character(labels)) > 0){
      labels <- labels %>%
        as.character() %>%
        stringr::str_replace_all('\\\"', '') %>%
        list()
      res$labels <- labels
      res <- tidyr::unnest(res, labels)
      res <- dplyr::mutate(res, value = TRUE)
      res <- tidyr::spread(unique(res), labels, value, fill = FALSE)
    }

    res <- dplyr::bind_rows(res, comments)
    # get value from issue info for all lines
    res <- dplyr::mutate_if(res, any_na, zoo::na.locf)
    res$issue <- issue_id
  }

  res$comment_url[1] <- paste0("https://github.com/", owner, "/", repo, "/issues/", issue_id)
  res$owner <- owner
  res$repo <- repo
  unique(res)

}

# to replace NA in comments with value from issue
# https://stackoverflow.com/questions/42052078/correct-syntax-for-mutate-if
any_na <- function(x){
  any(is.na(x[2:length(x)]))
}
