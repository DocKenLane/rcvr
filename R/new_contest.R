#' Instantiate \code{\link{contest}} object carefully
#'
#' @inheritParams contest
#' @return
#' @export
#'
#' @examples
#'
new_contest <- function(x,
                 CVRdata,
                 contest_name,
                 source,
                 CVR_files,
                 original,
                 contest_str,
                 date_str,
                 office,
                 alternatives,
                 ambiguities = c("undervote", "overvote"),
                 jurisdiction,
                 creator,
                 num_ranks,
                 num_records,
                 num_alternatives,
                 first_rank_col
){
  structure(x,
    class          = c("contest", "tbl_df"),
    CVRdata        = CVRdata,
    contest_name   = contest_name,
    source         = source,
    CVR_files      = CVR_files,
    original       = original,
    contest_str    = contest_str,
    date_str       = date_str,
    office         = office,
    alternatives   = alternatives,
    ambiguities    = ambiguities,
    jurisdiction   = jurisdiction,
    creator        = creator,
    num_ranks      = num_ranks,
    num_records    = num_records,
    num_alternatives    = num_alternatives,
    first_rank_col = first_rank_col
  )
}
