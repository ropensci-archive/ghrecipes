
<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)
[![Travis build
status](https://travis-ci.org/ropenscilabs/ghrecipes.svg?branch=master)](https://travis-ci.org/ropenscilabs/ghrecipes)
[![Coverage
status](https://codecov.io/gh/ropenscilabs/ghrecipes/branch/master/graph/badge.svg)](https://codecov.io/github/ropenscilabs/ghrecipes?branch=master)

# ghrecipes

The goal of ghrecipes is to provide helper functions for usual GitHub
*data mining* tasks, well at least the ones that are usual or useful for
us. :smile\_cat: Please suggest and discuss new recipes in [the issues
tracker\!](https://github.com/ropenscilabs/ghrecipes/issues)

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
devtools::install_github("ropenscilabs/ghrecipes")
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

| owner             | repo            | title                                                     | created\_at         | state  | author        | url                                                                                                                               | no\_comments |   id |
| :---------------- | :-------------- | :-------------------------------------------------------- | :------------------ | :----- | :------------ | :-------------------------------------------------------------------------------------------------------------------------------- | -----------: | ---: |
| hbc               | bcbioSingleCell | v0.1.5                                                    | 2018-05-02 16:26:31 | OPEN   | mjsteinbaugh  | <a href='https://github.com/hbc/bcbioSingleCell/pull/51'>https://github.com/hbc/bcbioSingleCell/pull/51</a>                       |            3 |   51 |
| PredictiveEcology | SpaDES.tools    | Fixed issue with empty CHECKSUMS.txt                      | 2018-04-27 06:43:49 | MERGED | CeresBarros   | <a href='https://github.com/PredictiveEcology/SpaDES.tools/pull/28'>https://github.com/PredictiveEcology/SpaDES.tools/pull/28</a> |            2 |   28 |
| PredictiveEcology | SpaDES.tools    | Cache into postProcess                                    | 2018-04-22 05:07:08 | MERGED | eliotmcintire | <a href='https://github.com/PredictiveEcology/SpaDES.tools/pull/26'>https://github.com/PredictiveEcology/SpaDES.tools/pull/26</a> |            1 |   26 |
| Azure             | doAzureParallel | Enable AAD and VNet Support                               | 2018-04-17 18:50:14 | MERGED | brnleehng     | <a href='https://github.com/Azure/doAzureParallel/pull/252'>https://github.com/Azure/doAzureParallel/pull/252</a>                 |            3 |  252 |
| jackwasey         | icd             | added icd10 ccs mapping                                   | 2018-03-24 21:39:50 | CLOSED | vitallish     | <a href='https://github.com/jackwasey/icd/pull/139'>https://github.com/jackwasey/icd/pull/139</a>                                 |            7 |  139 |
| mlr-org           | mlr             | Oneclass r learner h2o - for INTERNAL REVIEW - DONT MERGE | 2017-05-24 14:47:05 | OPEN   | berndbischl   | <a href='https://github.com/mlr-org/mlr/pull/1807'>https://github.com/mlr-org/mlr/pull/1807</a>                                   |            2 | 1807 |
| NA                | NA              | NA                                                        | NA                  | NA     | NA            | NA                                                                                                                                |           NA |   NA |
| NA                | NA              | NA                                                        | NA                  | NA     | NA            | NA                                                                                                                                |           NA |   NA |
| NA                | NA              | NA                                                        | NA                  | NA     | NA            | NA                                                                                                                                |           NA |   NA |
| NA                | NA              | NA                                                        | NA                  | NA     | NA            | NA                                                                                                                                |           NA |   NA |

## Use cases in the wild

  - [“hrbrpkgs: list Bob Rudis’
    packages”](http://www.masalmon.eu/2018/03/04/hrbrpkgs/) by [Maëlle
    Salmon](https://github.com/maelle/).

  - [“Lintr Bot, lintr’s Hester
    egg”](http://www.masalmon.eu/2018/03/30/lintr-bot/) by [Maëlle
    Salmon](https://github.com/maelle/).

  - [“Rectangling
    onboarding”](https://ropensci.org/blog/2018/04/26/rectangling-onboarding/)
    by [Maëlle Salmon](https://github.com/maelle/).

Add your use case to the list by [opening an
issue](https://github.com/ropenscilabs/ghrecipes/issues/new) \!

## Nice words

<blockquote class="twitter-tweet" data-lang="ca">

<p lang="en" dir="ltr">

Both the package actual use and its source code have been very useful to
me in understanding graphQL and the Github API. Thanks
<a href="https://twitter.com/ma_salmon?ref_src=twsrc%5Etfw">@ma\_salmon</a>\!
<a href="https://t.co/i8KUAMGfsn">https://t.co/i8KUAMGfsn</a>

</p>

— Christian Minich (@ChristianNolan)
<a href="https://twitter.com/ChristianNolan/status/990686685682962434?ref_src=twsrc%5Etfw">29
d’abril de 2018</a>

</blockquote>

## Meta

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md).

By participating in this project you agree to abide by its terms.
