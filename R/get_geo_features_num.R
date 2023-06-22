#' Get number of Features
#'
#' Returns the number of Features to estimate the loading time
#'
#' @param wfs the WFSClient
#' @param feature name of the feature (for example ms:LCOBJ)
#' @param bbox a character string of the bbox to resttrict the request to a specific geographic region (for example: `"2670694.24166528787463903,1243765.72999201575294137,2774916.42190200183540583,1287552.7291286657564342"`)
#'
#' @return number of features
#'
get_geo_features_num <- function(wfs,feature,bbox = NULL){
  geo_link <- wfs$getUrl()
  if (is.null(bbox)){
    full_link <- paste0(geo_link,'?SERVICE=WFS&REQUEST=GetFeature&VERSION=1.1.0&TYPENAMES=',feature,'&resultType=hits')
  } else {
    full_link <- paste0(geo_link,'?SERVICE=WFS&REQUEST=GetFeature&VERSION=1.1.0&TYPENAMES=',feature,'&resultType=hits&bbox=',bbox)
  }
  df <- sf::read_sf(full_link)
  num_fts <- nrow(df)
  num_fields <- ncol(df)-1
  message(glue::glue("Feature Collection with {num_fts} features and {num_fields} fields."))
  return(num_fts)
}
