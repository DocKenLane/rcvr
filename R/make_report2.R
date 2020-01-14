#' Title
#'
#' @export
#'
make_report2 <- function(tab){
  num_rounds       <- length(tab)
  alternatives     <- c(tab$round1$cvr_tabulation$StatusCode, "Exhausted by candidate")
  num_alternatives <- length(alternatives)
  mat              <- matrix(nrow = num_alternatives, ncol = num_rounds)
  for(idx in 1:num_rounds){
    alts     <- tab[[idx]]$cvr_tabulation$StatusCode
    tots     <- tab[[idx]]$cvr_tabulation$Total
    num_alts <- length(alts)
    for(jdx in 1:num_alternatives){
      mat[jdx, idx] <- 0
      for(kdx in 1:num_alts){
        if(alternatives[jdx] == alts[kdx]){
          mat[jdx, idx] <- tots[kdx]
        }
      }
    }
  }
  df <- data.frame("candidate" = alternatives, stringsAsFactors = FALSE)
  df <- mutate(df,  "r1" = mat[, 1])
  df <- mutate(df,  "r2" = mat[ ,2])
  df[5, 1]  <- " By Overvotes"
  df[6, 1]  <- " By Undervotes"
  df[7, 1]  <- " By Exhausted Choices"
  df
}