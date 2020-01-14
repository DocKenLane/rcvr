#' Build contest from CVR files
#'
#' Creates the central data frame for a \code{\link{contest}} instance. Typically called by the
#'   constructor.
#'
#' @param CVR A list of dataframes from raw CVR files
#'
#' @return A tibble of cleaned CVR data
#'
#' @export
#'
build_cvr_contest <- function(CVR){

  requireNamespace("dplyr")
  lapply(CVR, standardize_rankings) %>%
    dplyr::bind_rows() %>%
    clean_cvr_alternatives()
}
