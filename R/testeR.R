testeR <- function(str, bucket){
  max_seqU <- 2

  if(str_detect(string = str, pattern = "U")) {
    if(length(unlist(str_locate_all(str, "U"))) > 0) {
      str_locate_all(str, "U")[[1]][max_seqU, 1]
    } else {
      off_ballot
    }
  }
}
