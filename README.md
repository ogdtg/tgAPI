
# tgAPI

<!-- badges: start -->
<!-- badges: end -->

The goal of tgAPI is to access data from the [Open Government Data (OGD) portal of the Cantone of Thurgau, Switzerland](https://data.tg.ch/pages/start/) via API calls.

## Installation

You can install the development version of tgAPI from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("FLorenz/tgapi")
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



