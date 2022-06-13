#' Get metadata by ID
#'
#' @param dataset_id ID of the dataset from the catalog
#' @description Function to get specific metadata by ID from the datasets available on data.tg.ch
#' @return dataframe containing the metadata of the dataset with the corresponding ID from data.tg.ch
#' @import httr
#' @import jsonlite
#' @import glue
#' @export
#'
#' @examples
#' get_field_description("sk-stat-4")
#'
get_field_description <- function(dataset_id) {
  res = GET(glue::glue("https://data.tg.ch/api/v2/catalog/datasets/{dataset_id}"))
  result=fromJSON(rawToChar(res$content), flatten = TRUE)
  return(result$dataset$fields)
}
