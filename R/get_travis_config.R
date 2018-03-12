#' Get Travis config file of the package repo
#'
#' @inheritParams get_description
#'
#' @return a tibble of basic information from the Travis config file
#' @export
#'
#' @details
#' https://platform.github.community/t/query-repo-contents-with-graphql-api/1896
#' @examples
#' library("magrittr")
#' get_travis_config(owner = "ropensci", repo = "ropenaq")
get_travis_config <- function(owner, repo, branch = "master"){

  if(!is_package_repo(owner, repo)){
    stop("This repo is not a package repo, well it doesn't have NAMESPACE, man, R and DESCRIPTION.")
  }
  if(!".travis.yml" %in% get_contents(owner, repo)){
    stop("This repo doesn't have a Travis config file.")
  }
  query <- paste0('query {
                  repository(name: "', repo,'", owner: "', owner,'") {
                  object(expression: "', branch, ':', ".travis.yml", '") {
                  ... on Blob {
                  text
                  }
                  }
                  }
}')

  qry <- ghql::Query$new()
  qry$query('foobar', query)

  temp_path <- paste0(tempdir(), "\\.travis.yml")

  create_client()$exec(qry$queries$foobar) %>%
    jqr::jq(".data.repository.object.text") %>%
    jsonlite::fromJSON() %>%
    writeLines(temp_path)

  config <- yaml::read_yaml(temp_path) %>%
    purrr::map(toString)

  file.remove(temp_path)

  description <- get_description(owner, repo, branch)

  config <- cbind(description, config)
  tibble::as_tibble(config)

  }
