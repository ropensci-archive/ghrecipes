iterate <- function(query) {
  out <- ""
  last_cursor <- ""
  hasNextPage <- TRUE
  i <- 0
  while (hasNextPage) {
    i <- i + 1
    qry <- ghql::Query$new()
    qry$query('foobar', sprintf(query, last_cursor))
    res <- ghql_gh_cli$exec(qry$queries$foobar)
    last_cursor <- jqr::jq(res, "[..|.cursor?|select(.!=null)][-1]")
    hasNextPage <- as.logical(jqr::jq(res, "..|.hasNextPage?|select(.!=null)"))
    out <- paste0(out, res)
  }
  return(out)
}

create_client <- function(){
  token <- Sys.getenv("GITHUB_GRAPHQL_TOKEN")
  ghql_gh_cli <- ghql::GraphqlClient$new(
    url = "https://api.github.com/graphql",
    headers = httr::add_headers(Authorization = paste0("Bearer ", token))
  )
  ghql_gh_cli$load_schema()
  ghql_gh_cli
}
