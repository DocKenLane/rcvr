#' Create contest object
#'
#' Constructor for instances of S3 class
#'   \code{contest} implemented as \code{tbl_df} with metadata.
#'
#' @inheritParams params
#'
#' @return An instance of class \code{contest}.
#'
#' @export
#'
contest <- function(contest_name,
             source       = NULL,
             CVR_files    = NULL,
             original     = FALSE,
             contest_str  = NULL,
             date_str     = NULL,
             office       = NULL,
             jurisdiction = NULL,
             alternatives = NULL,
             ambiguities  = NULL,
             creator      = NULL,
             quietly      = TRUE
  ){

  if(missing(contest_name)) {
    stop("\n\n Must supply contest_name")
  }

  if(!original & is.null(source)) {
    stop("\n\n Must supply source")
  }

  if(!original & is.null(CVR_files)) {
    stop("\n\n Must supply CVR_files unless original == TRUE")
  }

  if(original & !is.null(alternatives)) {
    stop("\n\n Don't specify alternatives when downloading original")
  }

  if(original & is.null(contest_str)) {
    stop('\n\n Must supply contest_str if original == TRUE')
  }

  if(original) {
    key_values   <- read_contest_keys(contest_str)
    contest_name <- key_values$contest_name
    date_str     <- key_values$date_str
    jurisdiction <- "Maine"
    office       <- key_values$office
    source       <- key_values$cvr_url
    CVR_files    <- key_values$cvr_files
    alternatives <- key_values$alternatives
    ambiguities  <- key_values$ambiguities
  }

  CVR <- read_ME_contest(source,
    CVR_files = CVR_files,
    original,
    quietly   = quietly
  )

  df <- build_cvr_contest(CVR)

  first_rank_col <- 4
  last_col       <- ncol(df)

  num_ranks   <- last_col - first_rank_col + 1
  num_records <- nrow(df)

  ambiguities      <- c("undervote", "overvote")
  alternatives     <- sort(unique(unlist(df[first_rank_col:last_col], use.names = FALSE)))
  alternatives     <- alternatives[!(alternatives %in% ambiguities)]
  num_alternatives <- length(alternatives)

  msg <- paste(
           "\n\n               ", toupper("Metadata for"), as.character(contest_name), "\n\n",
           "source:", as.character(source), "\n",
           "CVR_files:\n", as.character(paste(CVR_files, collapse = ", ")), "\n",
           "original:", as.logical(original), "\n",
           "contest_str:", as.character(contest_str), "\n",
           "      date_str:", as.character(date_str), "\n",
           "        office:", as.character(office), "\n",
           "  alternatives:", as.character(paste(alternatives, collapse = ", ")), "\n",
           "    ambiguites:", as.character(paste(ambiguities, collapse = ", ")), "\n",
           "  jurisdiction:", as.character(jurisdiction), "\n",
           "       creator:", as.character(creator), "\n",
           "     num_ranks:", as.integer(num_ranks), "\n",
           "   num_records:", as.integer(num_records), "\n",
           "first_rank_col:", as.integer(first_rank_col)
           )
           #
  if(!quietly){
    message(msg)
    message(paste("\n                    A SAMPLE FROM", as.character(contest_name), "\n"))
    print(df)
  }

  new_contest(df,
    CVRdata        = CVR,
    contest_name   = as.character(contest_name),
    source         = as.character(source),
    CVR_files      = as.character(CVR_files),
    original       = as.logical(original),
    contest_str    = as.character(contest_str),
    date_str       = as.character(date_str),
    office         = as.character(office),
    alternatives   = as.character(alternatives),
    jurisdiction   = as.character(jurisdiction),
    creator        = as.character(creator),
    num_ranks      = as.integer(num_ranks),
    num_records    = as.integer(num_records),
    num_alternatives    = as.integer(num_alternatives),
    first_rank_col = as.integer(first_rank_col)
  )
}
