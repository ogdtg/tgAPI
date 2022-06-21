#' Get dataset by ID
#'
#' @param dataset_id ID of the dataset from the catalog
#' @description Function to get specific dataset by ID from the datasets available on data.tg.ch
#' @return dataframe containing the dataset with the corresponding ID from data.tg.ch
#'
#' @importFrom attempt stop_if_not
#' @importFrom glue glue
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET
#' @importFrom httr status_code
#' @export
#'
#' @examples
#' get_dataset("sk-stat-4")
#'
get_dataset = function(dataset_id){
  attempt::stop_if_not(dataset_id,
                       is.character,
                       msg = "dataset_id has to be a character string")
  res = httr::GET(glue::glue("https://data.tg.ch/api/v2/catalog/datasets/{dataset_id}/exports/json"))
  attempt::stop_if_not(.x = httr::status_code(res),
                       .p = ~ .x == 200,
                       msg = "The API returned an error. Please check your internet connection or visit data.tg.ch for more information")
  result=jsonlite::fromJSON(rawToChar(res$content), flatten = TRUE)
  return(result)
}
