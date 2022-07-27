#' Get Usage Data (only for internal usage with API Key)
#'
#' @param key API key from OpenDataSoft
#' @param start a date as character string in the format "YYYY-MM-DD" indicating the start of the date range in which the analytics data should be downloaded
#' @param end a date as character string in the format "YYYY-MM-DD" indicating the end of the date range in which the analytics data should be downloaded
#' @description Function to retrieve usage data from the backend. This function is for internal use only. An API key must be specified and passed to the function.
#' @return dataframe containing the usage analytics data.
#'
#' @importFrom attempt stop_if_not
#' @importFrom glue glue
#' @importFrom jsonlite fromJSON
#' @importFrom httr GET
#' @importFrom httr status_code
#' @export
#'
#'
get_usage = function(key,start,end){
  if(missing(start)|missing(end)){
    stop("Please provide start and end.")
  }

  if(missing(key)){
    stop("Please provide an API key.")
  }
  attempt::stop_if_not(start,
                       is.character,
                       msg = "start has to be a character string")
  attempt::stop_if_not(end,
                       is.character,
                       msg = "end has to be a character string")
  link = glue::glue("https://data.tg.ch/explore/dataset/ods-api-monitoring/download/?format=json&q=timestamp:%5B{start}T00:00:00Z+TO+{end}T23:59:59Z%5D&disjunctive.dataset_id=true&timezone=Europe/Berlin&lang=de&source=monitoring&apikey={key}")

  res = httr::GET(link)

  attempt::stop_if_not(.x = httr::status_code(res),
                       .p = ~ .x == 200,
                       msg = "The API returned an error. Did you specify start and end in the format 'YYYY-MM-DD'? If yes, please check if your API key is correct and if your internet connection is working. For more information visit data.tg.ch.")
  result=jsonlite::fromJSON(rawToChar(res$content), flatten = TRUE)
  return(result)

}
