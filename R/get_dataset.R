#' Get dataset by ID
#'
#' @param dataset_id ID of the dataset from the catalog
#' @description Function to get specific dataset by ID from the datasets available on data.tg.ch
#' @return dataframe containing the dataset with the corresponding ID from data.tg.ch
#' @importFrom glue glue
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET
#' @export
#'
#' @examples
#' get_dataset("sk-stat-4")
#'
get_dataset = function(dataset_id){
  res = httr::GET(glue::glue("https://data.tg.ch/api/v2/catalog/datasets/{dataset_id}/exports/json"))
  result=jsonlite::fromJSON(rawToChar(res$content), flatten = TRUE)
  return(result)
}
