#' Get the OGD catalog
#'
#' @return A dataframe with meta information on the OGD data catalog of the Cantone of Thurgau
#' @description Function to get meta information on the current catalog of datasets available on data.tg.ch
#' @export
#'
#' @importFrom glue glue
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET
#'
#' @examples
#' get_catalog()
#'
get_catalog <- function() {
  res = httr::GET("https://data.tg.ch/api/v2/catalog/exports/json")
  result=jsonlite::fromJSON(rawToChar(res$content), flatten = TRUE)
  return(result)
}
