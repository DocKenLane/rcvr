#' Glean CVR \code{alternatives}
#'
#' Assumes the data confined to columns \code{4:(length(CVR) - 1)}.
#'   Will be modified or extended for other jurisdictions.
#'
#' @param CVR
#'
#' @return
#'
#' @export
#'
glean_cvr_names <- function(CVR){
  cols <- 4:(length(CVR) - 1)
  sort(unique(unlist(CVR[cols], use.names = FALSE)))
}
