#' Get ballot codes
#'
#' @inheritParams params 
#'
#' @export
#'
get_codes <- function(cntst){
  num_alternatives        <- attr(x = cntst, which = "num_alternatives")
  alternative_code        <- as.character(LETTERS[1:num_alternatives])
  names(alternative_code) <- attr(x = cntst, "alternatives")
  ambiguity_code          <- c("undervote" = "U", "overvote" = "O")
  cvr_mark_code           <- append(alternative_code, ambiguity_code)
  
  encode_cvr_rankings(cntst, cvr_mark_code)
}