#' Replace names
#'
#' Puts new names for a column of choices in CVR ballot dataframe
#'   Called by code{clean_cvr_alternatives()} using code{lapply()} to
#'   create cleaner CVR table for a \code{contest} instance..
#'
#' @param x A vector of values (char).
#'
#' @param new_names A vector of new names for the values (char).
#'
#' @return A vector with new names.
#'
#' @export
#'
replace_names <- function(x, new_names){
  len <- length(new_names)
  for (idx in 1:len) {
    x[grepl(new_names[idx], x)] <- new_names[idx]
  }
  x
}
