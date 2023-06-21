#' Get Geo Data
#'
#' Retrieves the data for the given dataset_id and returns a data.frame. It is recommended to pass the feature you want to get data on as an argument (see see \code{\link[tgAPI]{get_geo_features}}.
#'
#' @param dataset_id dataset_id from the catalog ( \code{\link[tgAPI]{getCatalog}})
#' @param feature the name or the title of a feature. If the feature is NULL, the first feature in the feature table will be used. Provide "all" to receive all features in a list of data.frames.
#'
#' @return a data.frame or a list of data.frames usable with sf
#' @export
#'
get_geo_data <- function(dataset_id, feature=NULL) {
  list_elem <- get_geo_features_wfs(dataset_id)
  fts <- list_elem[[2]]
  wfs <- list_elem[[1]]
  caps <- wfs$getCapabilities()

  if (is.null(feature)) {
    message(paste0("No Feature given. Possible features are ",paste(fts$title, collapse = ", "), "\nFunction takes the first Feature (",fts$title[1],") as default."))
    rel_fts <- fts$name[1]
  } else if (feature == "all"){
    message("Download all features")
    rel_fts <- fts$name
    data <- lapply(rel_fts, function(x){
      ft <- caps$findFeatureTypeByName(x)
      if(length(ft)>0){
        temp <- ft$getFeatures()
        return(temp)
      }
    })
    names(data) <- fts$title
    return(data)
  } else if (feature %in% fts$name) {
    rel_fts <- feature
  } else if (feature %in% fts$title) {
    rel_fts <- fts$name[which(fts$title==feature)]
  } else {
    fts_name <- paste(fts$name, collapse = ", ")
    fts_title <- paste(fts$title, collapse = ", ")
    stop(
      paste0(
        "Feature is not valid. It must be either one of the feature names or one of the feature titles.\nPossible feature names: ",
        fts_name,
        "\nPossible feature titles. ",
        fts_title
      )
    )
  }
  # wfs <- get_wfs(dataset_id)

  ft <- caps$findFeatureTypeByName(rel_fts)
  if(length(ft)>0){
    data <- tryCatch({ft$getFeatures()
      },error = function(cond){
        stop(glue::glue("Feature could not be retrieved. For more information please visit https://data.tg.ch/explore/dataset/{dataset_id}/information/ or contact us under ogd@tg.ch"))
      })
    return(data)
  } else {
    stop("Feature is not valid")
  }
}

