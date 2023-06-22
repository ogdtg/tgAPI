#' Get Geo Data in Slices (vectorized)
#'
#' Downloads packages of data in slices and binds it to one data.frame
#'
#' @param num_fts num of features (see `get_geo_features_num()`)
#' @param count_num number of records that should be downloaded
#' @param feature the feature name
#' @param bbox a character string of the bbox to resttrict the request to a specific geographic region (for example: `"2670694.24166528787463903,1243765.72999201575294137,2774916.42190200183540583,1287552.7291286657564342"`)
#' @param wfs the WFSClient
#'
#' @return a data.frame of class `sf`
#' @export
#'
get_geo_feature_slice_vec <- function(num_fts,count_num, wfs,feature,bbox = NULL) {

  pb <- utils::txtProgressBar(min = 0,      # Minimum value of the progress bar
                              max = num_fts, # Maximum value of the progress bar
                              style = 3,    # Progress bar style (also available style = 1 and style = 2)
                              width = 50,   # Progress bar width. Defaults to getOption("width")
                              char = "=")   # Character used to create the bar  df_list <- list()
  counter <-  0
  #count_num = 1000
  df_nrow <- count_num

  while (df_nrow == count_num) {
    df_list[[paste0(counter)]] <-
      get_geo_feature_slice(startindex = counter,
                            count_num = count_num,
                            wfs = wfs,
                            feature = feature,
                            bbox = bbox)
    df_nrow <- nrow(df_list[[paste0(counter)]])
    counter <- counter + df_nrow
    utils::setTxtProgressBar(pb, counter)

  }

  data <- df_list %>% bind_rows()

  close(pb)

  return(data)
}
