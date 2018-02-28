#' Get Travis config file of the package repo
#'
#' @param owner
#' @param repo
#' @param branch master by default
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



  res <- cli$exec(qry$queries$foobar)

  temp_path <- paste0(tempdir(), "\\.travis.yml")

  res %>%
    jqr::jq(".data.repository.object.text") %>%
    jsonlite::fromJSON() %>%
    writeLines(temp_path)

  config <- yaml::read_yaml(temp_path) %>%
    purrr::map(toString)

  description <- get_description(owner, repo, branch)

  config <- cbind(description, config)
  tibble::as_tibble(config)

  }
