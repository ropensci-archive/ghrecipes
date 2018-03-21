
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

Don't miss conversations by your favorite developpers, or comments by your favorite [styling bot](https://github.com/lintr-bot). In that function, only the latest results are returned, and an issue can be a PR.

``` r
ghrecipes::spy("lintr-bot", type = "Issue")
#> NULL
convos <- ghrecipes::spy("lintr-bot", type = "PullRequest")
knitr::kable(convos[1:10,])
```

| repo                          | title                           | created\_at         | state  | author        | url                                                                                                                               |  no\_comments|
|:------------------------------|:--------------------------------|:--------------------|:-------|:--------------|:----------------------------------------------------------------------------------------------------------------------------------|-------------:|
| PredictiveEcology/SpaDES.core | robustObjectSize                | 2018-03-20 02:14:01 | OPEN   | eliotmcintire | <a href='https://github.com/PredictiveEcology/SpaDES.core/pull/54'>https://github.com/PredictiveEcology/SpaDES.core/pull/54</a>   |             2|
| uribo/jpndistrict             | Follow up sf (0.6-0) update     | 2018-03-20 00:11:46 | MERGED | uribo         | <a href='https://github.com/uribo/jpndistrict/pull/11'>https://github.com/uribo/jpndistrict/pull/11</a>                           |             6|
| ptl93/AEDA                    | Tle cluster                     | 2018-03-18 12:39:58 | MERGED | ptl93         | <a href='https://github.com/ptl93/AEDA/pull/33'>https://github.com/ptl93/AEDA/pull/33</a>                                         |             7|
| HealthCatalyst/healthcareai-r | Continuous integration set up   | 2018-03-16 20:34:00 | MERGED | michaellevy   | <a href='https://github.com/HealthCatalyst/healthcareai-r/pull/947'>https://github.com/HealthCatalyst/healthcareai-r/pull/947</a> |            13|
| HealthCatalyst/healthcareai-r | Travis and AppVeyor set up      | 2018-03-16 17:32:30 | CLOSED | michaellevy   | <a href='https://github.com/HealthCatalyst/healthcareai-r/pull/944'>https://github.com/HealthCatalyst/healthcareai-r/pull/944</a> |            11|
| ropensci/drake                | Add `reduce_plan()`             | 2018-03-16 01:43:13 | MERGED | wlandau       | <a href='https://github.com/ropensci/drake/pull/327'>https://github.com/ropensci/drake/pull/327</a>                               |             2|
| PredictiveEcology/SpaDES.core | Fix when alsoExtract is NULL    | 2018-03-15 21:40:36 | MERGED | ygc2l         | <a href='https://github.com/PredictiveEcology/SpaDES.core/pull/53'>https://github.com/PredictiveEcology/SpaDES.core/pull/53</a>   |             1|
| Azure/doAzureParallel         | Added optional retry count flag | 2018-03-15 19:33:35 | MERGED | brnleehng     | <a href='https://github.com/Azure/doAzureParallel/pull/235'>https://github.com/Azure/doAzureParallel/pull/235</a>                 |             2|
| HealthCatalyst/healthcareai-r | Mikem 901 readdata              | 2018-03-12 19:39:54 | MERGED | mmastand      | <a href='https://github.com/HealthCatalyst/healthcareai-r/pull/934'>https://github.com/HealthCatalyst/healthcareai-r/pull/934</a> |            28|
| stianlagstad/chimeraviz       | Adds lintr test                 | 2018-03-11 00:00:51 | CLOSED | stianlagstad  | <a href='https://github.com/stianlagstad/chimeraviz/pull/40'>https://github.com/stianlagstad/chimeraviz/pull/40</a>               |             2|

Meta
----

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md).

By participating in this project you agree to abide by its terms.
