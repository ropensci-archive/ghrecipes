#' Get committers to master
#'
#' @inheritParams get_contents
#'
#' @return data.frame of login and name
#' @export
#'
#' @examples
get_master_committers <- function(repo, owner){
  query <- paste0('{
                  repository(owner: "', owner, '", name: "', repo,'") {
                   ref(qualifiedName:"refs/heads/master") {
      target {
                  ... on Commit {
                  history(first: 100, after: %s) {
                  edges {
                  node {
                  author {
                  user {
                  login
                  name
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
}
}
}
}')
  res <- iterate(query)
  res %>%
    jqr::jq(".data.repository.ref.target.history.edges[].node.author.user") %>%
    jqr::jq("{login: .login,
            name: .name}")%>%
    jqr::combine() %>% # single json file
    jsonlite::fromJSON() %>%
    tibble::as_tibble() %>%
    unique()
}
