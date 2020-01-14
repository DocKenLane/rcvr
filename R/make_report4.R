#' Title
#'
#' @export
#'
make_report4 <- function(tab){
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
  df <- mutate(df,  "r3" = mat[, 3])
  df <- mutate(df,  "r4" = mat[, 4])
  df[6, 1]  <- " By Overvotes"
  df[7, 1]  <- " By Undervotes"
  df[11, 1] <- " By Exhausted Choices"
  df[c(1:5,8:10, 6, 7, 11),]
}