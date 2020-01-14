#' Temporary buffer for downloading file data.
#'
#' @inheritParams params
#'
#' @param ext File extension.
#'
#' @return A buffer for subsequent reading.
#'
#' @export
#'
#' @examples
#'  download_buf(url = "My favorite webfile", ext= ".txt")
#'
download_buf <- function(url, ext){

  requireNamespace("RCurl", quietly = TRUE)

  temp.file <- paste0(tempfile(), ext)
  download.file(url = url, destfile = temp.file, mode = "wb")
  temp.file
}
