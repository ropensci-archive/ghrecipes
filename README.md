# ghrecipes

The goal of ghrecipes is to provide helper functions for usual GitHub data mining tasks, well at least the one that are usual for us. :smile_cat:

It uses[ GitHub V4 API](https://developer.github.com/v4/) queried thanks to the [`ghql` package](https://github.com/ropensci/ghql). It then formats results using the [`jqr` package](https://github.com/ropensci/jqr), interface to [jq](https://stedolan.github.io/jq/). :rocket:

## Installation

You can install ghrecipes from github with:


``` r
# install.packages("devtools")
devtools::install_github("maelle/ghrecipes")
```
