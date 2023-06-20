#' Get Geo Features and WFS
#'
#' Returns a list containing the WFSClient and a data.frame with the available features (layers) for the given dataset_id
#'
#' @param dataset_id dataset_id from the catalog (see \code{\link[tgAPI]{getCatalog}})
#'
#' @return a list containing the WFSClient and a data.frame with the available features (layers)
#'
get_geo_features_wfs <- function(dataset_id) {
  wfs <- get_wfs(dataset_id)
  fts <- wfs$getFeatureTypes(pretty = TRUE)
  return(list(wfs,fts))
}
