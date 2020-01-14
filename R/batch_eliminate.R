#' Eliminate alternatives
#'
#' Eliminates alternatives by subsetting
#'   \code{continuing_alternatives}.
#'
#' @inheritParams params
#'
#' @return A character vector of subset of \code{continuing_alternatives}.
#'
#' @export
#'
batch_eliminate <- function(round,
                            alternative_code,
                            continuing_alternatives,
                            quietly = TRUE)
{
  tab_tbl <- round$alt_tabulation %>%
               mutate("code" = alternative_code[Alternative]) %>%
               arrange(Total) %>%
               mutate("MaxPossible" = cumsum(Total))

  if(!quietly) {
    print(tab_tbl[c(1, 2, 4)])
  }

  num_alternatives             <- length(continuing_alternatives)
  num_vulnerable               <- num_alternatives - 1

  continuing                   <- !as.logical(num_vulnerable:0)
  continuing[num_alternatives] <- TRUE
  for(alternative in 1:num_vulnerable) {
    needed_to_advance       <- tab_tbl$Total[alternative + 1]
    max_possible            <- tab_tbl$MaxPossible[alternative]
    continuing[alternative] <- (max_possible > needed_to_advance)
  }

  tab_tbl$code[continuing]
}

