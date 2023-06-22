#' Get Slice of Feature
#'
#' Downloads a specific number of feature data
#'
#' @param startindex index of the record to start
#' @param count number of records that should be downloaded
#' @param feature the feature name
#' @param bbox a character string of the bbox to resttrict the request to a specific geographic region (for example: `"2670694.24166528787463903,1243765.72999201575294137,2774916.42190200183540583,1287552.7291286657564342"`)
#' @param wfs the WFSClient
#'
#' @return data.frame of class `sf`
#' @export
#'
get_geo_feature_slice <- function(startindex, count_num, wfs, feature,bbox =NULL) {
  url <- httr::parse_url(wfs$getUrl())
  url$query <- list(
    service = "wfs",
    version = "2.0.0",
    request = "GetFeature",
    typename = feature,
    startindex = startindex,
    count = count_num,
    bbox = bbox
  )
  request <- httr::build_url(url)
  data <- sf::read_sf(request)
  return(data)
}
