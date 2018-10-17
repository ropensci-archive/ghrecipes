
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

## Tokens

To access GitHub, `ghrecipes` looks for tokens stored in the system
environment in the following order of precedence:

1.  GITHUB\_GRAPHQL\_TOKEN
2.  GITHUB\_TOKEN
3.  GITHUB\_PAT

Most functions require only the `repo` scope. However, `get_teams()`
requires either `read:org` or `read:discussion` scopes, and
`get_collaborators()` requires push access to the repository of
interest.

For step-by-step guidance on getting and storing a GitHub token, refer
to the
[instructions](https://usethis.r-lib.org/articles/articles/usethis-setup.html#get-and-store-a-github-personal-access-token)
in the `usethis` package.

## Examples

Don’t miss conversations by your favorite developers or comments by your
favorite [styling bot](https://github.com/lintr-bot). In that function,
only the latest results are returned, and an issue can be a PR.

``` r
ghrecipes::spy("lintr-bot", type = "Issue")
#> NULL
convos <- ghrecipes::spy("lintr-bot", type = "PullRequest")
knitr::kable(convos[1:10,])
```

| owner             | repo         | title                         | created\_at         | state  | author   | url                                                                                                                               | no\_comments |  id |
| :---------------- | :----------- | :---------------------------- | :------------------ | :----- | :------- | :-------------------------------------------------------------------------------------------------------------------------------- | -----------: | --: |
| PredictiveEcology | SpaDES.tools | move RandomFields to Suggests | 2018-09-18 23:04:49 | MERGED | achubaty | <a href='https://github.com/PredictiveEcology/SpaDES.tools/pull/50'>https://github.com/PredictiveEcology/SpaDES.tools/pull/50</a> |            1 |  50 |
| PredictiveEcology | SpaDES.tools | rasterizeReduced uses crs     | 2018-09-04 20:40:18 | MERGED | achubaty | <a href='https://github.com/PredictiveEcology/SpaDES.tools/pull/49'>https://github.com/PredictiveEcology/SpaDES.tools/pull/49</a> |            1 |  49 |
| bokeh             | rbokeh       | Update to 0.12.5              | 2017-06-07 20:11:51 | OPEN   | hafen    | <a href='https://github.com/bokeh/rbokeh/pull/217'>https://github.com/bokeh/rbokeh/pull/217</a>                                   |            7 | 217 |
| NA                | NA           | NA                            | NA                  | NA     | NA       | NA                                                                                                                                |           NA |  NA |
| NA                | NA           | NA                            | NA                  | NA     | NA       | NA                                                                                                                                |           NA |  NA |
| NA                | NA           | NA                            | NA                  | NA     | NA       | NA                                                                                                                                |           NA |  NA |
| NA                | NA           | NA                            | NA                  | NA     | NA       | NA                                                                                                                                |           NA |  NA |
| NA                | NA           | NA                            | NA                  | NA     | NA       | NA                                                                                                                                |           NA |  NA |
| NA                | NA           | NA                            | NA                  | NA     | NA       | NA                                                                                                                                |           NA |  NA |
| NA                | NA           | NA                            | NA                  | NA     | NA       | NA                                                                                                                                |           NA |  NA |

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
