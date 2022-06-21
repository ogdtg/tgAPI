#' Get the OGD catalog
#'
#' @return A dataframe with meta information on the OGD data catalog of the Cantone of Thurgau
#' @description Function to get meta information on the current catalog of datasets available on data.tg.ch
#' @export
#'
#' @importFrom attempt stop_if_not
#' @importFrom glue glue
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET
#' @importFrom httr status_code
#'
#' @examples
#' get_catalog()
#'
get_catalog <- function() {
  res = httr::GET("https://data.tg.ch/api/v2/catalog/exports/json")
  attempt::stop_if_not(.x = httr::status_code(res),
              .p = ~ .x == 200,
              msg = "The API returned an error. Please check your internet connection or visit data.tg.ch for more information")
  result=jsonlite::fromJSON(rawToChar(res$content), flatten = TRUE)
  return(result)
}
