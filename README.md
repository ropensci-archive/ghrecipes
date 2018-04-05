
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)
[![Travis build
status](https://travis-ci.org/maelle/ghrecipes.svg?branch=master)](https://travis-ci.org/maelle/ghrecipes)
[![Build
status](https://ci.appveyor.com/api/projects/status/8bh3hpjevms1rni0?svg=true)](https://ci.appveyor.com/project/ropensci/ghrecipes)
[![Coverage
status](https://codecov.io/gh/maelle/ghrecipes/branch/master/graph/badge.svg)](https://codecov.io/github/maelle/ghrecipes?branch=master)

# ghrecipes

The goal of ghrecipes is to provide helper functions for usual GitHub
*data mining* tasks, well at least the ones that are usual or useful for
us. :smile\_cat: Please suggest and discuss new recipes in [the issues
tracker\!](https://github.com/maelle/ghrecipes/issues)

It uses[GitHub V4 API](https://developer.github.com/v4/) queried thanks
to the [`ghql` package](https://github.com/ropensci/ghql). Read more
about [GitHub V4 API advantages
here](https://developer.github.com/v4/#why-is-github-using-graphql). It
then formats results using the [`jqr`
package](https://github.com/ropensci/jqr), interface to
[jq](https://stedolan.github.io/jq/). Read an intro to `jqr` power
[here](http://www.carlboettiger.info/2017/12/11/data-rectangling-with-jq/).
:rocket:

## Installation

You can install ghrecipes from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("maelle/ghrecipes")
```

## Examples

Don’t miss conversations by your favorite developpers, or comments by
your favorite [styling bot](https://github.com/lintr-bot). In that
function, only the latest results are returned, and an issue can be a
PR.

``` r
ghrecipes::spy("lintr-bot", type = "Issue")
#> NULL
convos <- ghrecipes::spy("lintr-bot", type = "PullRequest")
knitr::kable(convos[1:10,])
```

| owner             | repo           | title                                                              | created\_at         | state  | author        | url                                                                                                                                 | no\_comments |   id |
| :---------------- | :------------- | :----------------------------------------------------------------- | :------------------ | :----- | :------------ | :---------------------------------------------------------------------------------------------------------------------------------- | -----------: | ---: |
| juliasilge        | tidytext       | throws warning if tf\_idf is negative                              | 2018-04-03 19:55:32 | OPEN   | EmilHvitfeldt | <a href='https://github.com/juliasilge/tidytext/pull/112'>https://github.com/juliasilge/tidytext/pull/112</a>                       |            3 |  112 |
| PredictiveEcology | reproducible   | faster to try to make it not matter what                           | 2018-04-03 06:03:17 | MERGED | eliotmcintire | <a href='https://github.com/PredictiveEcology/reproducible/pull/21'>https://github.com/PredictiveEcology/reproducible/pull/21</a>   |            2 |   21 |
| HealthCatalyst    | healthcareai-r | Levy1011vignettes                                                  | 2018-04-02 17:50:18 | MERGED | michaellevy   | <a href='https://github.com/HealthCatalyst/healthcareai-r/pull/1012'>https://github.com/HealthCatalyst/healthcareai-r/pull/1012</a> |            4 | 1012 |
| HealthCatalyst    | healthcareai-r | Levy tibble summary                                                | 2018-04-01 18:10:54 | MERGED | michaellevy   | <a href='https://github.com/HealthCatalyst/healthcareai-r/pull/1002'>https://github.com/HealthCatalyst/healthcareai-r/pull/1002</a> |            3 | 1002 |
| PredictiveEcology | reproducible   | mergeCache                                                         | 2018-03-29 18:29:33 | MERGED | eliotmcintire | <a href='https://github.com/PredictiveEcology/reproducible/pull/18'>https://github.com/PredictiveEcology/reproducible/pull/18</a>   |            2 |   18 |
| PredictiveEcology | SpaDES.core    | change objectSize to objSize – name conflict with R.oo::objectSize | 2018-03-26 23:48:22 | MERGED | eliotmcintire | <a href='https://github.com/PredictiveEcology/SpaDES.core/pull/57'>https://github.com/PredictiveEcology/SpaDES.core/pull/57</a>     |            1 |   57 |
| PredictiveEcology | reproducible   | memoise – loadFromRepo                                             | 2018-03-26 17:41:25 | MERGED | eliotmcintire | <a href='https://github.com/PredictiveEcology/reproducible/pull/17'>https://github.com/PredictiveEcology/reproducible/pull/17</a>   |            3 |   17 |
| PredictiveEcology | quickPlot      | thin fixes – bugfixes, SpatialPolygonsDataFrames                   | 2018-03-26 05:32:12 | MERGED | eliotmcintire | <a href='https://github.com/PredictiveEcology/quickPlot/pull/13'>https://github.com/PredictiveEcology/quickPlot/pull/13</a>         |            2 |   13 |
| ptl93             | AEDA           | added getEps                                                       | 2018-03-25 17:12:44 | MERGED | MiGraber      | <a href='https://github.com/ptl93/AEDA/pull/39'>https://github.com/ptl93/AEDA/pull/39</a>                                           |            5 |   39 |
| PredictiveEcology | SpaDES.core    | prepInputs – attemptErrorChecking arg                              | 2018-03-25 06:32:04 | MERGED | eliotmcintire | <a href='https://github.com/PredictiveEcology/SpaDES.core/pull/56'>https://github.com/PredictiveEcology/SpaDES.core/pull/56</a>     |            1 |   56 |

## External use cases

  - [“hrbrpkgs: list Bob Rudis’
    packages”](http://www.masalmon.eu/2018/03/04/hrbrpkgs/).

  - [“Lintr Bot, lintr’s Hester
    egg”](http://www.masalmon.eu/2018/03/30/lintr-bot/)

## Meta

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md).

By participating in this project you agree to abide by its terms.
