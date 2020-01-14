#' Tabulate instant runoff round
#'
#' @description Tabulates the \code{result} of an instant runoff round for a ranked choice \code{contest}.
#'
#' @param result A \code{list} of results from \code{tabulate_cvr_rank}.
#'
#' @param cvr_status_code  Codes used encode disposition of a cvr during an instant runoff round.
#'
#' @param round_number The runoff round number.
#'
#' @return A \code{tabulation} instance.
#'
#' @export
#'
tabulate_round<- function(cntst,
                           result,
                           cvr_status_code,
                           round_number
                          )
{
  num_ballots            <- attr(x = cntst, which = "num_records")
  continuing_ballot_idx  <- !(unlist(result) %in% c("exu", "exo", "exc"))
  num_continuing_ballots <- sum(continuing_ballot_idx)

  alt_tbl  <- table(unlist(result[continuing_ballot_idx]))
  name_idx <- match(x = names(alt_tbl), table = cvr_status_code)
  alt_tab  <- tibble("Alternative" = names(cvr_status_code)[name_idx],
                           "Total" = as.integer(alt_tbl))

  cvr_tbl  <- table(unlist(result))
  name_idx <- match(x = names(cvr_tbl), table = cvr_status_code)
  cvr_tab  <- tibble(
                     "StatusCode" = names(cvr_status_code)[name_idx],
                     "Total"      = as.integer(cvr_tbl)
                     ) %>%
                      mutate(
                             "Percent"      = 100*Total/num_continuing_ballots,
                             "TotalPercent" = 100*Total/num_ballots
                             )

  maximum_percent <- max(cvr_tab$Percent)
  list(
    "round_number"           = round_number,
    "num_continuing_ballots" = num_continuing_ballots,
    "maximum_percent"        = maximum_percent,
    "cvr_tabulation"         = cvr_tab,
    "alt_tabulation"         = alt_tab,
    "continuing_ballot_idx"  = continuing_ballot_idx,
    "result"                 = result
  )
}
