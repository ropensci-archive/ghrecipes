
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip) [![Travis build status](https://travis-ci.org/maelle/ghrecipes.svg?branch=master)](https://travis-ci.org/maelle/ghrecipes) [![Build status](https://ci.appveyor.com/api/projects/status/8bh3hpjevms1rni0?svg=true)](https://ci.appveyor.com/project/ropensci/ghrecipes) [![Coverage status](https://codecov.io/gh/maelle/ghrecipes/branch/master/graph/badge.svg)](https://codecov.io/github/maelle/ghrecipes?branch=master)

ghrecipes
=========

The goal of ghrecipes is to provide helper functions for usual GitHub *data mining* tasks, well at least the ones that are usual or useful for us. :smile\_cat: Please suggest and discuss new recipes in [the issues tracker!](https://github.com/maelle/ghrecipes/issues)

It uses[GitHub V4 API](https://developer.github.com/v4/) queried thanks to the [`ghql` package](https://github.com/ropensci/ghql). Read more about [GitHub V4 API advantages here](https://developer.github.com/v4/#why-is-github-using-graphql). It then formats results using the [`jqr` package](https://github.com/ropensci/jqr), interface to [jq](https://stedolan.github.io/jq/). Read an intro to `jqr` power [here](http://www.carlboettiger.info/2017/12/11/data-rectangling-with-jq/). :rocket:

Installation
------------

You can install ghrecipes from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("maelle/ghrecipes")
```

Notes on use
------------

-   See a very basic use case [here](http://www.masalmon.eu/2018/03/04/hrbrpkgs/).

Examples
--------

Don't miss conversations by your favorite developpers.

``` r
convos <- ghrecipes::spy("github")
knitr::kable(convos)
```

| repo                 | title                                    | created\_at         | state  | author        | url                                                                                                                 |  no\_comments|
|:---------------------|:-----------------------------------------|:--------------------|:-------|:--------------|:--------------------------------------------------------------------------------------------------------------------|-------------:|
| sorin-ionescu/prezto | Rename and rebrand the project           | 2012-06-14 23:58:14 | CLOSED | sorin-ionescu | <a href='https://github.com/sorin-ionescu/prezto/issues/197'>https://github.com/sorin-ionescu/prezto/issues/197</a> |           183|
| javan/whenever       | Rake jobs don't run in some environments | 2009-06-15 16:22:10 | CLOSED | NA            | <a href='https://github.com/javan/whenever/issues/10'>https://github.com/javan/whenever/issues/10</a>               |             5|

Meta
----

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md).

By participating in this project you agree to abide by its terms.
