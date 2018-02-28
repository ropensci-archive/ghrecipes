#' Get description of the package repo
#'
#' @param owner
#' @param repo
#' @param branch master by default
#'
#' @return a tibble of basic information from the DESCRIPTION
#' @export
#'
#' @details
#' https://platform.github.community/t/query-repo-contents-with-graphql-api/1896
#' @examples
#' library("magrittr")
#' get_description(owner = "ropensci", repo = "ropenaq")
get_description <- function(owner, repo, branch = "master"){

  if(!is_package_repo(owner, repo)){
    stop("This repo is not a package repo, well it doesn't have NAMESPACE, man, R and DESCRIPTION.")
  }

  query <- paste0('query {
                  repository(name: "', repo,'", owner: "', owner,'") {
                  object(expression: "', branch, ':', "DESCRIPTION", '") {
                  ... on Blob {
                  text
                  }
                  }
                  }
}')

  qry <- ghql::Query$new()
  qry$query('foobar', query)



  res <- cli$exec(qry$queries$foobar)

  temp_path <- paste0(tempdir(), "\\DESCRIPTION")

  res %>%
    jqr::jq(".data.repository.object.text") %>%
    jsonlite::fromJSON() %>%
    writeLines(temp_path)

  description <- desc::description$new(file = temp_path)

  file.remove(temp_path)

  tibble::tibble(package = description$get("Package"),
                 repo = repo,
                 owner = owner,
                 branch = branch,
                 title = description$get("Title"),
                 maintainer = description$get_maintainer(),
                 dependencies = list(description$get_deps()),
                 system_requirements = description$get("SystemRequirements"),
                 description = description$get("Description"))

  }
