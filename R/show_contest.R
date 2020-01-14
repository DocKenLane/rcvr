#' Show contest data
#'
#' @export
#'
show_contest <- function(cntst){
  cvr     <- unlist(attr(cntst, "CVR_files"))
  alt     <- unlist(attr(cntst, "alternatives"))
  num_cvr <- length(cvr)
  num_alt <- length(alt)
  df <- data.frame(Item             = rep("", num_cvr + num_alt + 5),
                   Value            = rep("", num_cvr + num_alt + 5),
                   stringsAsFactors = FALSE)
  df[1, 1] <- "Office"
  df[1, 2] <- attr(cntst, "office")
  df[2, 1] <- "Jurisdiction"
  df[2, 2] <- attr(cntst, "jurisdiction")
  df[3, 1] <- "CVR location"
  df[3, 2] <- attr(cntst, "source")
  df[4:(3+num_cvr), 1] <- "CVR file"
  for(idx in 1:num_cvr){
    df[idx+3, 2] <- cvr[idx]
  }
  df[(4+num_cvr):(3+num_cvr+num_alt), 1]   <- "Candidate"
  for(idx in 1:num_alt){
    df[3+num_cvr+idx, 2] <- alt[idx]
  }
  df[4+num_cvr+num_alt, 1] <- "Number of Candidates"
  df[4+num_cvr+num_alt, 2] <- num_alt
  df[5+num_cvr+num_alt, 1] <- "Number of Ranks"
  df[5+num_cvr+num_alt, 2] <- attr(cntst, "num_ranks")
  df[6+num_cvr+num_alt, 1] <- "Number of Ballots"
  df[6+num_cvr+num_alt, 2] <- attr(cntst, "num_records")
  # msg <- paste(
  #   "\n                ", toupper("Metadata for"), attr(cntst, "contest_name"), "\n",
  #   "Source:\n  ", attr(cntst, "source"), "\n",
  #   "CVR_files:\n  ", paste(attr(cntst, "CVR_files"), collapse = "\n   "),
  #   "\n Office:\n  ", attr(cntst, "office"), "\n",
  #   "Alternatives:\n  ", paste(attr(cntst, "alternatives"), collapse = "\n   "),
  #   "\n Jurisdiction:\n  ", attr(cntst, "jurisdiction"), "\n",
  #   "Number of choices:\n  ", attr(cntst, "num_ranks"), "\n",
  #   "Number of ballots:\n  ", attr(cntst, "num_records"), "\n"
  # )
  # message(msg)
  df
}

