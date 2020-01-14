#' Encode cast vote record rankings
#'
#' Encodes rankings on each ranked choice cvr as a single
#'   string \code{rank_str} with a character [A-Z] for each
#'   ranking, designating a specific \code{alternative_code}
#'   or \code{ambiguity_code}.
#'
#' @inheritParams params
#'
#' @param cvr_mark_code The concatenation of \code{alternative_code} and
#'   \code{ambiguity_code}.
#'   The vector of characters to used to encode
#'   each ballot. Alternatives use \code{as.character(LETTERS[1:num_alternatives])}
#'   with U and O for alternatives. \code{names(cvr_mark_code)} corresponds to
#'   entries in the choice fields of \code{cntst}.
#'   
#'
#' @return A \code{rank_str})
#'   derived from ranking data for each record.
#'
#' @export
#'
encode_cvr_rankings <- function(cntst, cvr_mark_code){
  requireNamespace("plyr")
  requireNamespace("dplyr")

  if(!("contest" %in% class(cntst))) {
    stop("Failure: encode_cvr_rankings() expects contest instance")
  }

  alternatives <- attr(cntst, "alternatives")
  ambiguities  <- attr(cntst, "ambiguities")
  choices      <- c(alternatives, ambiguities)

  num_alternatives <- attr(cntst, "num_alternatives")
  first_rank       <- attr(cntst, "first_rank_col")
  last_rank        <- first_rank + attr(cntst, "num_ranks") - 1
  num_records      <- attr(cntst, "num_records")

  bs <- cntst[first_rank:last_rank]
  result <- lapply(bs, plyr::mapvalues, from = choices, to = cvr_mark_code) %>%
              data.frame(stringsAsFactors = FALSE)

  rank_str <- as.character(1:num_records)
  for (idx in 1:num_records) {
    rank_str[idx] <- paste0(as.character(result[idx, ]), collapse = "")
  }
  rank_str
}
