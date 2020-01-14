show_tabulation <- function(round){
  msg <- paste("\nCompleted tabulation for round number", as.character(round$round_number), "...")
  message(msg)

  msg <- paste(
   "Continuing Ballots:", as.character(round$num_continuing_ballots),
   "   Maximum Percent:", as.numeric(round$maximum_percent)
   )
  print(msg)
  print(round$cvr_tabulation)
}

