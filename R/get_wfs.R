#' Get WFSClient
#'
#' Get the WFSCLient for given dataset_id by using ows4R
#'
#' @param dataset_id dataset_id from the catalog (see \code{\link[tgAPI]{getCatalog}})
#'
#' @return a ows4R WFS Environment ()
#' @seealso \code{\link[ows4R]{WFSClient}}
#'
get_wfs <- function(dataset_id) {
  res <-
    httr::GET(glue::glue(
      "https://data.tg.ch/api/v2/catalog/datasets/{dataset_id}"
    ))

  if(res$status_code != 200){
    stop(glue::glue("{dataset_id} is not a valid dataset_id on data.tg.ch"))
  }

  metas <- content(res)

  geo_link <- metas$dataset$metas$default$attributions[[1]]

  if (is.null(geo_link)){
    stop(glue::glue("No ows.geo.tg found. Is the selected dataset really a geo dataset? Please check on
         https://data.tg.ch/explore/dataset/{dataset_id}/information/"))
  }
  if (!stringr::str_detect(geo_link,"^https://ows.geo.tg.ch/.*")){
    stop(glue::glue("Dataset does not contain ows.geo.tg link. Is the selected dataset really a geo dataset? Please check on
         https://data.tg.ch/explore/dataset/{dataset_id}/information/"))
  }

  wfs <- geo_link %>%
    stringr::str_remove("\\?.*") %>%
    ows4R::WFSClient$new(serviceVersion = "2.0.0")

  return(wfs)
}
