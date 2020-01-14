#' Conduct instant runoff
#'
#' @description Conducts a ranked choice instant runoff. Does not resolve ties, as yet.
#'
#' @param cntst A \code{contest} instance.
#'
#' @inheritParams params
#'
#' @return A \code{tabulation} instance.
#'
#' @export
#'
conduct_runoff <- function(cntst,
  sequentialU = FALSE,
  max_U       = 2,
  sequentialO = FALSE,
  max_O       = 1,
  june2018    = FALSE,
  quietly     = TRUE)
{
  num_alternatives        <- attr(x = cntst, which = "num_alternatives")
  num_ballots             <- attr(x = cntst, "num_records")

  ambiguity_code          <- c("undervote" = "U", "overvote" = "O")
  alternative_code        <- as.character(LETTERS[1:num_alternatives])
  names(alternative_code) <- attr(x = cntst, "alternatives")
  continuing_alternatives <- alternative_code

  cvr_mark_code     <- append(alternative_code, ambiguity_code)

  exhaustion_type         <- c("Exhausted by undervote" = "exu",
                               "Exhausted by overvote" = "exo",
                               "Exhausted by candidate" = "exc"
                               )
  cvr_status_code         <- append(x = alternative_code,
                                value = exhaustion_type)
  rank_str  <- encode_cvr_rankings(cntst, cvr_mark_code)

  round_number          <- 1
  rounds                <- list()
  results               <- list()
  tabulation_incomplete <- TRUE
  while(tabulation_incomplete){
    result <- lapply(rank_str,
      tabulate_cvr_rank,
      continuing_alternatives = continuing_alternatives,
      sequentialU             = sequentialU,
      max_U                   = max_U,
      sequentialO             = sequentialO,
      max_O                   = max_O,
      june2018                = june2018
    )

    round <- tabulate_round(cntst = cntst,
      result           = result,
      cvr_status_code  = cvr_status_code,
      round_number     = round_number
    )
    round_str            <- paste0("round", as.character(round_number))
    results[[round_str]] <- unlist(result)
    rounds[[round_str]]  <- round

    if(!quietly){show_tabulation(round)}

    # Check to see if it is over. If not, eliminate an alternative.
    if(round$maximum_percent > 50.0) {
      if(!quietly){print("A winner has been declared! \\n")}
      tabulation_incomplete <- FALSE
    } else {
      msg <- paste0("No winner in round ",
                   as.character(round_number), ". Invoking batch elimination ..."
                   )
      if(!quietly){print(msg)}

      continuing_alternatives <-
        batch_eliminate(round,
                        alternative_code        = alternative_code,
                        continuing_alternatives = continuing_alternatives
                       )
    }
    round_number <- round_number + 1
  }
  rounds
}
