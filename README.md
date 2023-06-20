
# tgAPI


<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of tgAPI is to access data from the [Open Government Data (OGD) portal of the Cantone of Thurgau, Switzerland](https://data.tg.ch/pages/start/) via API calls.

*Release Note 20.06.2023: From now on it is also possible to retrieve geo data from the portal**

## Installation

You can install the development version of tgAPI from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ogdtg/tgAPI")
```

## Example

To see the available datasets and the corresponding dataset IDs, you can use the `get_catalog` function.

``` r
library(tgAPI)
full_catalog <- get_catalog()
```

In the catalog you can search for the desired dataset and take the corresponding dataset ID directly.
With that specific dataset ID you can export the dataset as a data.frame by using the `get_dataset` function (for example the dataset "sk-stat-94").

``` r
data <- get_dataset("sk-stat-94")
```

If you are unsure about the labels and their meaning you can also download more detailed field descriptions by using the `get_field_description` function.

``` r
fields <- get_field_description("sk-stat-94")
```
## Geodata

Geo Data can also be retrieved by using the dataset ID.

It is recommended to download one feature at a time and not all features at once. To see which features are available you can use the `get_geo_features` command.


``` r
features <- get_geo_features("erdwarme")
```

You receive a dataset with all possible features. Now you can chose a feature you want to get the data from and downlaod it with the `get_geo_data` function.

``` r
features <- get_geo_data(dataset_id = "erdwarme", feature = "Erdwärmesondenbohrungen")
```

You can also download all features at once by setting `feature = "all"`. However, this can result in a very large amount of data that will take a rather long time to download. Therefore this option is only recommended in specific use cases.
