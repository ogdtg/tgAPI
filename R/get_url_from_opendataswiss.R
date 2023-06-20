#' Get OWS URL from opendata.swiss
#'
#' Retrieves the OWS URL from opendata.swiss
#'
#' @param dataset_id dataset_id from the catalog ( \code{\link[tgAPI]{getCatalog}})
#'
#' @return URL
#'
get_url_from_opendataswiss <- function(dataset_id) {
  link <- glue::glue("https://ckan.opendata.swiss/api/3/action/package_show?id={dataset_id}")

  res <- httr::GET(link)

  test <- httr::content(res)

  result <- test$result$resources[[1]]$url

  return(result)
}
