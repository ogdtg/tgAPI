
# tgAPI


<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The purpose of tgAPI is to enable access to data from the [Open Government Data (OGD) portal of the Cantone of Thurgau, Switzerland](https://data.tg.ch/pages/start/) via API calls.

*Release Note 20.06.2023: From now on it is also possible to retrieve geo data from the portal.*

## Installation

You can install the development version of tgAPI from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("ogdtg/tgAPI")
```

## Example

To explore the available datasets and their corresponding dataset IDs, you can use the `get_catalog` function.

``` r
library(tgAPI)
full_catalog <- get_catalog()
```

Within the catalog, you can search for the desired dataset and directly obtain the corresponding dataset ID. Once you have the dataset ID, you can export the dataset as a data.frame using the `get_dataset` function. For instance, to retrieve the dataset "sk-stat-94", you can use the following code:

``` r
data <- get_dataset("sk-stat-94")
```

If you need more information about the labels and their meanings, you can download detailed field descriptions using the `get_field_description` function.

``` r
fields <- get_field_description("sk-stat-94")
```
## Geodata

You can also retrieve geodata by utilizing the dataset ID.

To ensure efficient data retrieval, it is recommended to download one feature at a time instead of all features simultaneously. You can determine the available features by using the `get_geo_features` command.

``` r
features <- get_geo_features("erdwarme")
```

This will provide you with a dataset containing all the available features. You can then choose a specific feature from which you wish to retrieve the data and download it using the `get_geo_data` function.

Larger Geodata will be downloaded in slices of 1000 features per request, to avoid memory overload.


``` r
geo_data <- get_geo_data(dataset_id = "erdwarme", feature = "Erdwärmesondenbohrungen")
```

Alternatively, you can download all features at once by setting `feature = "all". However, please be aware that this may result in a substantial amount of data and a longer download time. Therefore, this option is recommended only for specific use cases.
