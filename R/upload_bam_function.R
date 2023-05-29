#' Upload BAM file
#'
#' This function allow to scan the BAM file and to view it as a dataframe
#'
#' @usage upload_bam(file_bam)
#' @param file_bam BAM file
#' @return a dataframe containing the information of the BAM file
#' @author Erica Pirotta\cr Politecnico di Milano\cr Maintainer: Erica
#' Pirotta \cr E-Mail: <erica.pirotta@@mail.polimi.it>
#' @references \url{https://en.wikipedia.org/wiki/SAM_(file_format)}\cr
#'
#' @examples
#' bam_file <- system.file('extdata', 'example.bam', package="ShowAlignment")
#' upload_bam(bam_file)
#'
#' @importFrom Rsamtools scanBam
#'
#' @export
upload_bam <- function(file_bam){
    bam <- scanBam(file_bam)
    bam <- as.data.frame(bam)
}

