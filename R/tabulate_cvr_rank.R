#' Tabulate CVR rank string
#'
#' @description
#'   Implements rules for the disposition of a cast vote record \code{rank_str},
#'   including the disposition of ambiguities such as overvotes and undervotes.
#'
#' @param sequentialO If \code{TRUE}, \code{max_O} sequential overvotes \code{exhaust}
#'   the cvr by undervote, \code{status_code = "exo"}.
#'
#' @param max_O The number of overvotes triggering a potential overvote,
#'   according to the value of \code{sequentialO}.
#'
#' @param sequentialU If \code{TRUE}, \code{max_u} sequential undervotes \code{exhaust}
#'   the cvr by undervote, \code{status_code = "exu"}.
#'
#' @param max_U The number of undervotes triggering a potential undervote,
#'   according to the value of \code{sequentialO}.
#'
#' @return A value from \code{status_code}
#'
tabulate_cvr_rank <- function(rank_str,
    continuing_alternatives,
    sequentialO = FALSE,
    max_O       = 1,
    sequentialU = FALSE,
    max_U       = 2,
    june2018   = FALSE
    )
{
  requireNamespace("stringr")
#
# Provides for pattern not found
  off_ballot <- nchar(rank_str) + 1
#
###
# Find the position of the first occurence of an overvote, if any.
  sub_str <- str_extract(rank_str, "^(.*?)O{1}")
  if(is.na(sub_str)){
    pos_overvote <- off_ballot
  } else {
    pos_overvote <- nchar(sub_str)
  }
###
#
### Code to detect first position of \code{max_conU}
### occurence of undervotes, if any.
  if(!sequentialU)
  {
    max_conU  <- 2
    regex_str <- paste0("^(.*?)(U){", max_conU, "}")
    sub_str <- str_extract(rank_str, regex_str)
    if(is.na(sub_str)) {
      pos_undervote <- off_ballot
    } else {
      pos_undervote <- nchar(sub_str)
    }
  }
# ###
#
# ### Code to detect first position of \code{max_seqU}
# ### ocurrences of undervotes, if any.
  if(sequentialU)
  {
    max_seqU <- 2
    regex_str <- paste0("^(.*?U){", max_seqU, "}")
    sub_str <- str_extract(rank_str, regex_str)
    if(is.na(sub_str)) {
      pos_undervote <- off_ballot
    } else {
      pos_undervote <- nchar(sub_str)
    }
# ###
#
# ### Code to duplicate Maine June 2018 primary.
     if(june2018 & str_detect(rank_str, "^U(A|B|C|D|E|F|G|H)U(A|B|C|D|E|F|G|H)")){
       pos_undervote <- off_ballot
     }
  }
# ###
#
# ###
# # Find the position of the first continuing alternative, if any.
  locs <- list()
  for(alternative in continuing_alternatives)
    locs[[alternative]] <- str_locate(rank_str, alternative)[1]

  locs            <- unlist(locs)
  locs_continuing <- !is.na(locs)
  if(sum(locs_continuing) > 0)
  {
    pos_continuing <- min(locs[locs_continuing])[1]
  } else {
    pos_continuing <- off_ballot
  }

# Determine overvote exhaustion
  if((pos_overvote < pos_continuing) & (pos_overvote < pos_undervote)) {
    return("exo")
  }

# Determine undervote exhaustion
  if((pos_undervote < pos_continuing  & pos_undervote < pos_overvote) |

     (pos_continuing == off_ballot    & grepl("U", rank_str))) {
    return("exu")
  }

# Determine alternative exhaustion
  if(pos_continuing == off_ballot ){
    return("exc")
  }

# # The ballot is continuing and is awarded to
  # the highest ranked continuing alternative on the \code{rank_str}.
  if(pos_continuing < off_ballot){
    return(substr(rank_str, pos_continuing, pos_continuing))
  }

# No overvote, undervote, or continuing alternative found.
  stop("error")
}
