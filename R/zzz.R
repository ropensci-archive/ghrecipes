# function for iterating a query
# only works for a query with one cursor and one hasNextPage
iterate <- function(query) {
  out <- ""
  last_cursor <- ""
  hasNextPage <- TRUE
  i <- 0
  while (hasNextPage) {
    i <- i + 1
    qry <- ghql::Query$new()
    qry$query('foobar', sprintf(query, last_cursor))
    res <- create_client()$exec(qry$queries$foobar)
    last_cursor <- jqr::jq(res, "[..|.cursor?|select(.!=null)][-1]")
    hasNextPage <- as.logical(jqr::jq(res, "..|.hasNextPage?|select(.!=null)"))
    out <- paste0(out, res)
  }
  return(out)
}

#check for token; some calls work only with specific scopes
get_token <- function() {
  token <- Sys.getenv("GITHUB_GRAPHQL_TOKEN")
  if(token == ""){
    token <- Sys.getenv("GITHUB_TOKEN", Sys.getenv("GITHUB_PAT"))
  }
  if(token == ""){
    stop("Please set your GITHUB_GRAPHQL_TOKEN environment variable.")
  }
  return(token)
}

# function for creating the client
# it first checks whether there's a token
# and then only creates the client if it doesn't already exist
create_client <- function(){
  token <- get_token()

  if(!exists("ghql_gh_cli")){
    ghql_gh_cli <- ghql::GraphqlClient$new(
      url = "https://api.github.com/graphql",
      headers = httr::add_headers(Authorization = paste0("Bearer ", token))
    )
    ghql_gh_cli$load_schema()
    ghql_gh_cli <<- ghql_gh_cli

  }
  return(ghql_gh_cli)
}
