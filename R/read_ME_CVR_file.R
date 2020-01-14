#' Read Maine CVR file
#'
#' @inheritParams readxl::read_excel
#' @inheritParams params
#'
#' @return A tibble of raw CVR data, Maine style.
#'
#' @export
#'
read_ME_CVR_file <- function(url,
  original = FALSE,
  quietly  = TRUE)
{
  requireNamespace("readxl")
  requireNamespace("dplyr")

  if(original) {
    tryCatch(
      error = function(cnd) message(paste0("\n\n Stumbled downloading ", url)),
      path <- download_buf(url, ext = ".xlsx")
    )
  } else {
    path <- url
  }

  tryCatch(
    error = function(cnd) message("\n\n Stumbled reading"),
    {
    dat <- readxl::read_excel(path = path, col_types = "text") %>%
                     dplyr::mutate(source_file = url)
    cols <- as.character(ncol(dat))
    rows <- as.character(nrow(dat))

    if(!quietly) {
      message(paste("Found", rows, "records in", url, " ..."))
      message(paste("Found", cols, "columns in", url, " ...\n\n"))
    }
    dat
    }
  )
}
