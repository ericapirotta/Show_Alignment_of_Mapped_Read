#' Upload SAM file
#'
#' This function allow to read a file in SAM format and to view it as a dataframe
#'
#' @usage upload_sam(file_sam)
#' @param file_sam SAM file
#' @return a dataframe containing the information of the SAM file
#' @author Erica Pirotta\cr Politecnico di Milano\cr Maintainer: Erica
#' Pirotta \cr E-Mail: <erica.pirotta@@mail.polimi.it>
#' @references \url{https://en.wikipedia.org/wiki/SAM_(file_format)}\cr
#'
#' @examples
#' sam_file <- system.file('extdata', 'example.sam', package="ShowAlignment")
#' upload_sam(sam_file)
#'
#' @importFrom utils read.delim
#'
#' @export
upload_sam <- function(file_sam){
    sam <- read.delim(file_sam)
}
