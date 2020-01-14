#' Read Maine contest files
#'
#' Used to read Cast Vote Record files (\code{*.xlsx}) for a State of Maine
#'   Ranked Choice Instant Runoff election.
#'
#' @inheritParams utils::download.file
#'
#' @inheritParams params
#'
#' @return A list of dataframes.
#'
#' @export
#'
read_ME_contest <- function(source,
                     CVR_files,
                     original = FALSE,
                     quietly  = TRUE
){

  if(missing(CVR_files)){
    stop("\n\n Must supply CVR_files")
  }

  file_names <- paste0(source , "/", CVR_files)
  dfs <- lapply(file_names,
    read_ME_CVR_file,
    original = original,
    quietly  = quietly
  )

  nfiles <- as.character(length(dfs))
  if(!quietly) {
    message(paste("Found and read", nfiles, "files ..."))

    cols <- sapply(dfs, ncol)
    if(length(unique(cols)) > 1) {
      stop(paste("Non-unique column counts:", cols))
    } else {
      message(paste("Found unique column length", as.character(cols[1]), "in", nfiles, "files ..."))
    }
  }
  dfs
}
