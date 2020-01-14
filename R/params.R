#' rcvr parameters
#'
#' @description
#'   The rcvr package provides functions for reading, analyzing, and visualizing
#'   ballot data from Ranked Choice Voting elections.
#'
#'   When \code{\link{rcvr}} is installed, missing *url* arguments default to the
#'   *extdata* subfolder of the installed *rcvr* package folder on the local machine
#'   (*system.file("extdata", package = "rcvr").
#'   If space is an issue, the utility *dump_default_files()* is provided for your
#'   cobvenience.
#'
#'   For ease of of development, second copy of default data files are installed the
#'   *extdata* subfolder of the *rcvr* package development directory
#'   (*system.file("extdata", package = "rcvr*).
#'
#' @param alternative Candidate or alternative for a \code{\link{contest}} (char).
#'
#' @param alternatives Container for all alternatives in a \code{contest} (char).
#'
#' @param alternative_code Character vector of codes \code{"[A-N]"} for representing
#'   \code{alternatives} in a \code{contest}.
#'
#' @param ambiguity The string found on the CVR representing an unresolved ranking.
#'
#' @param ambiguities Container for ambiguities in a \code{contest}.
#'
#' @param contest_name For example "Democratic Primary".
#'   With padding removed, used for first part of the \code{*.rda}
#'   file name for serializing the contest.
#'
#' @param contest_str Must reference an \code{object} value in \code{key_values.txt}.
#'
#' @param continuing_alternatives A subset of \code{alternative_code} representing
#'   continuing alternatives in a tabulation.
#'
#' @param cntst A \code{contest} instance.
#'
#' @param creator Human creating \code{contest} object.
#'
#' @param CVR A list of dataframes with cast vote records. Usually raw data saved
#'   used by the constructor and saved as metadata for a \code{contest} instance.
#'
#' @param CVR_files Cast Vote Record file names.
#'
#' @param date_str Encoded as MM/DD/YYYY. Forms the second part of the
#'   \code{*.rda} file name for serializing the contest.
#'
#' @param june2018 If \code{TRUE} duplicates official State tabulations.
#' 
#' @param jurisdiction Set as appropriate.
#'
#' @param source Folder of CVR files.
#'
#' @param office Encodes the name of the office or referendum at issue.
#'   With padding  removed, forms the third part of the
#'   \code{*.rda} file name for serializing the contest.
#'
#' @param original If \code{original == TRUE}, \code{contest_str} must match
#'   an \code{object} value in \code{contest_keys.txt} file in working directory,
#'   with \code{cvr_url} value
#'   and all \code{cvr_file} values needed to reconstruct the election.
#'
#' @param path Some folder, somewhere. Typically defaults to working directory.
#'
#' @param quietly When \code{FALSE} many routines get noisy.
#'
#' @param round An instance of a RC/IR runoff round.
#'
#' @param url Universal Resource Locator.
#'
#' @name params
NULL
# > NULL
