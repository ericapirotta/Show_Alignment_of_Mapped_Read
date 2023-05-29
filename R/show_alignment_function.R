#' Show the Alignment to the Reference Genome
#'
#'This function reads in a BAM/SAM file, taking a specific read entry
#'and the reference genome and show the precise alignment to the
#'reference genome according to the CIGAR string of the read.
#'
#' @usage show_alignment(read, bam_sam_file, ref_genome)
#' @param read Sequence of bases (ACGT)
#' @param bam_sam_file BAM/SAM file
#' @param ref_genome Reference genome from UCSC
#' @return position, cigar string, read and reference sequence
#' @author Erica Pirotta\cr Politecnico di Milano\cr Maintainer: Erica
#' Pirotta \cr E-Mail: <erica.pirotta@@mail.polimi.it>
#' @references \url{https://en.wikipedia.org/wiki/Sequence_alignment#Representations}\cr
#'
#'@examples
#' library(BSgenome.Hsapiens.UCSC.hg38)
#' file <- system.file('extdata', 'example.bam', package="ShowAlignment")
#' show_alignment("GCATAACCCCTCTCTGAATCAATGAATCGCAAATCAGCCACTTTAATTAAGCTAAGCCCTTACTAGACCAATGGGACTTAAACCCGCAAACACTTAGTTAA", file, Hsapiens)
#'
#' @importFrom Rsamtools scanBam
#' @importFrom data.table %like%
#' @importFrom GenomicAlignments cigarOpTable
#' @importFrom GenomicAlignments cigarRangesAlongQuerySpace
#' @importFrom GenomicAlignments cigarRangesAlongQuerySpace
#' @importFrom Biostrings getSeq
#' @importFrom IRanges isEmpty
#' @import BSgenome.Hsapiens.UCSC.hg38
#' @import utils
#'
#' @export
show_alignment <- function(read, bam_sam_file, ref_genome) {
    #Upload the BAM/SAM file based on the file type (BAM or SAM) and convert it into a dataframe
    df <- if (grepl('*.bam', bam_sam_file)) {upload_bam(bam_sam_file)} else {upload_sam(bam_sam_file) }

    #Search for the entry read
    read_row <- df[df$seq %like% read,]
    read_row <- read_row[, c("rname","pos","cigar","seq")]
    read_row <- unique(read_row)
    cigar <- read_row$cigar

    #Compute the length of the reference according to the CIGAR
    cigar_table <- as.data.frame(cigarOpTable(cigar))

    #Compute how many Deletion and Insertion we have in the CIGAR string:
    D_length <- cigar_table$D
    I_length <- cigar_table$I
    #The length of the reference according to the CIGAR is given by the sum of the CIGAR values minus the number of Insertion.
    cigar_lengths <- rowSums(cigar_table) - I_length

    #Start-End position searched in the Reference sequence
    start <- as.numeric(read_row$pos)
    end <-start + cigar_lengths -1

    #Reference sequence determination considering chr and start-end position.
    ref_seq <- paste0((getSeq(ref_genome, read_row$rname , start=start, end=end, strand="+")), sep = "")

    #Find the position of DELETION and INSERTION
    range_read <- cigarRangesAlongQuerySpace(cigar, flag=NULL, before.hard.clipping=FALSE, after.soft.clipping=FALSE, ops="D", drop.empty.ranges=FALSE, reduce.ranges=FALSE, with.ops=FALSE)
    D_pos <- ifelse(D_pos <- isEmpty(range_read), 0, as.numeric(range_read@unlistData@start)) # start represent the position
    range_ref <- cigarRangesAlongQuerySpace(cigar, flag=NULL, before.hard.clipping=FALSE, after.soft.clipping=FALSE, ops="I", drop.empty.ranges=FALSE, reduce.ranges=FALSE, with.ops=FALSE)
    I_pos <- ifelse(I_pos <- isEmpty(range_ref), 0, as.numeric(range_ref@unlistData@start))

    #Show the eventual DELETION in the read
    pattern <- paste0('^([A-Z]{',D_pos-1, '})([A-Z]+)$') #pattern
    replacement <- paste0('\\1', strrep('-', D_length ), '\\2') #replacement
    read <- gsub(pattern, replacement, read)

    #Show the eventual INSERTION in the reference sequence
    pattern <- paste0('^([A-Z]{',I_pos-1, '})([A-Z]+)$') #pattern
    replacement <- paste0('\\1', strrep('-', I_length), '\\2') #replacement
    ref_seq <- gsub(pattern, replacement, ref_seq)

    position <- paste0(read_row$rname, "  ", start, "-", end)

    # Show the output (position, cigar, reference and read)
    cat(paste0( "\n   ", "Pos: ", position, "\n ", "Cigar: ", cigar , "\n   ","Ref: ", ref_seq, "\n  ", "Read: ", read, "\n"))
}
