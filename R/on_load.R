.onLoad <- function(libname, pkgname){
  ghql_gh_cli <<- create_client()
} # nocov end
