#' Get dataset by ID
#'
#' @param dataset_id ID of the dataset from the catalog
#' @description Function to get specific dataset by ID from the datasets available on data.tg.ch
#' @return dataframe containing the dataset with the corresponding ID from data.tg.ch
#' @import httr
#' @import jsonlite
#' @import glue
#' @export
#'
#' @examples
#' get_dataset("sk-stat-4")
#'
get_dataset = function(dataset_id){
  res = GET(glue::glue("https://data.tg.ch/api/v2/catalog/datasets/{dataset_id}/exports/json"))
  result=fromJSON(rawToChar(res$content), flatten = TRUE)
  return(result)
}
