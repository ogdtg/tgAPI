#' Get Geo Features
#'
#' Returns a data.frame with the available features (layers) for the given dataset_id
#'
#' Please note that some Features are not available via this process.
#'
#'
#' @param dataset_id dataset_id from the catalog (see \code{\link[tgAPI]{getCatalog}})
#'
#' @return data.frame with the available features (layers)
#' @export
#'
get_geo_features <- function(dataset_id) {
  wfs <- get_wfs(dataset_id)
  fts <- wfs$getFeatureTypes(pretty = TRUE)
  return(fts)
}
