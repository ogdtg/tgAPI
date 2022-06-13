#' Get the OGD catalog
#'
#' @return A dataframe with meta information on the OGD data catalog of the Cantone of Thurgau
#' @description Function to get meta information on the current catalog of datasets available on data.tg.ch
#' @import httr
#' @import jsonlite
#' @import glue
#' @export
#'
#' @examples
#' get_catalog()
#'
get_catalog <- function() {
  res = GET("https://data.tg.ch/api/v2/catalog/exports/json")
  result=fromJSON(rawToChar(res$content), flatten = TRUE)
  return(result)
}
