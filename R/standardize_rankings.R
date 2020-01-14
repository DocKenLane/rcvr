#' Standardize rankings
#'
#' Standardizes \code{rankings}. Assumes Maine cast Vote record style.
#'
#' @param x Dataframe containing Maine cast vote records.
#'
#' @inheritParams params
#'
#' @return A tibble.
#'
#' @export
#'
standardize_rankings <- function(x,
                                 ext = ""){
  cnames <- c("id", "precinct", "style",
               paste0("1st", ext),
               paste0("2nd", ext),
               paste0("3rd", ext),
               paste0(as.character(4:29),"th", ext))
  names(x) <- cnames[1:ncol(x)]
  x
}
