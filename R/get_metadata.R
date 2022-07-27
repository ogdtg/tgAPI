#' Get detailed Meta Data (only for internal usage with API Key)
#'
#' @param key API key from OpenDataSoft
#' @description Function to retrieve meta data from the backend. This function is for internal use only. An API key must be specified and passed to the function.
#' @return dataframe containing the meta data.
#'
#' @importFrom attempt stop_if_not
#' @importFrom glue glue
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET
#' @importFrom httr status_code
#' @export
#'
#'
get_metadata = function(key){
  if(missing(key)){
    stop("Please provide an API key.")
  }
  attempt::stop_if_not(key,
                       is.character,
                       msg = "key has to be a character string")
  link = glue::glue("https://data.tg.ch/explore/dataset/ods-datasets-monitoring/download/?format=json&disjunctive.dataset_id=true&timezone=Europe/Berlin&lang=de&source=monitoring&apikey={key}")

  res = httr::GET(link)

  attempt::stop_if_not(.x = httr::status_code(res),
                       .p = ~ .x == 200,
                       msg = "The API returned an error. Please check if your API key is correct and if your internet connection is working. For more information visit data.tg.ch.")
  result=jsonlite::fromJSON(rawToChar(res$content), flatten = TRUE)
  return(result)


}
