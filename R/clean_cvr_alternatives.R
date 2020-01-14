#' Clean CVR alternatives names
#'
#' Creates clean \code{alternative} for contest ranking data.
#'
#' @return Return a \code{\link{contest}} with a clean \code{alternative}.
#'
#' @export
#'
clean_cvr_alternatives <- function(CVR,
  quietly = TRUE)
{
  all_names <- glean_cvr_names(CVR)
  found     <- as.character(length(all_names))

  full_names <- sort(unique(gsub("[ ]*\\(\\d*\\)", "", all_names)))
  full_names <- full_names[!(full_names %in% c("overvote","undervote"))]
  if(!quietly) {
    message(paste("Found", found, "distinct choices."))
    print(tibble(all_names))

    found      <- as.character(length(full_names))

    message(paste("Found", found, "distinct full name choices."))
    print(tibble(full_names))
    message("Using full names for alternatives.")
  }

  dplyr::bind_cols(CVR[1:3],
           lapply(CVR[,4:(ncol(CVR) - 1)],
             replace_names,
             new_names = full_names)
           )
}
