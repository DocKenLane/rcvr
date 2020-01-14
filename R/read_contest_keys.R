#' Read contest keys
#'
#' Get names and such for loading election data.
#'
#' @inheritParams utils::download.file
#' @inheritParams base::requireNamespace
#' @inheritParams params
#'
#' @return Names for an election
#'
#' @examples
#' read_key_values(contest_str = "d2_June", path = "My data folder")
#'
#' @export
#'
read_contest_keys <- function(contest_str, path = getwd()){

  requireNamespace(package = "utils")
  if(missing(contest_str)){
    stop('\n\nTo call this function a "contest_str" is required. Try "d2_June", for example.\n\n')
  }

  file_name <- paste0(path,"/contest_keys.txt")
  tryCatch(
    error = function(cnd){
      message('\n\nStumbled reading contest_keys. Check the format.\n\n')
    },

    dat <- read.table(file_name,
      sep = "|",
      col.names = c(
        "object",
        "field",
        "value"
      ),
      stringsAsFactors = FALSE,
      comment.char = "#"
    )
  )
  cvr_files         <- dat[dat$object == contest_str    & dat$field == "cvr_file", 3]
  alternatives      <- dat[dat$object == contest_str    & dat$field == "alternative", 3]
  ambiguities       <- dat[dat$object == contest_str    & dat$field == "ambiguity", 3]
  cvr_url           <- dat[dat$object == contest_str    & dat$field == "cvr_url", 3]
  re_url            <- dat[dat$object == contest_str    & dat$field == "re_url", 3]
  contest_name      <- dat[dat$object == contest_str    & dat$field == "contest_name", 3]
  office            <- dat[dat$object == contest_str    & dat$field == "office", 3]
  date_str          <- dat[dat$object == contest_str    & dat$field == "date_str", 3]
  path              <- dat[dat$object == contest_str    & dat$field == "path", 3]
  munidist_url      <- dat[dat$object == "munidist"     & dat$field == "url", 3]
  townshipdist_url  <- dat[dat$object == "townshipdist" & dat$field == "url", 3]
  munidist_file     <- dat[dat$object == "munidist"     & dat$field == "file_name", 3]
  townshipdist_file <- dat[dat$object == "townshipdist" & dat$field == "file_name", 3]
  voting_place_url  <- dat[dat$object == "voting_place" & dat$field == "url", 3]

  list(
    cvr_files         = cvr_files,
    alternatives      = alternatives,
    ambiguities       = ambiguities,
    cvr_url           = cvr_url,
    re_url            = re_url,
    path              = path,
    contest_name      = contest_name,
    office            = office,
    date_str          = date_str,
    munidist_url      = munidist_url,
    munidist_file     = munidist_file,
    townshipdist_url  = townshipdist_url,
    townshipdist_file = townshipdist_file,
    voting_place_url  = voting_place_url
  )
}
