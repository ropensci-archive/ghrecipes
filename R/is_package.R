
#' Is this repo a package
#'
#' @inheritParams get_contents
#'
#' @return logical
#' @export
#'
#' @examples
#' is_package_repo("maelle", "convertagd")
#' is_package_repo("maelle", "roregistry")
is_package_repo <- function(owner, repo){
  contents <- get_contents(owner, repo)
  all(c("NAMESPACE", "DESCRIPTION", "R", "man") %in% contents)
}
