## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----style, echo = FALSE, results = 'asis'------------------------------------
library(BiocStyle)

## ---- echo = FALSE------------------------------------------------------------
library(knitr)

## ---- echo = FALSE------------------------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg38)

## ----setup--------------------------------------------------------------------
library(ShowAlignment)

## -----------------------------------------------------------------------------
bam_file <- system.file('extdata', 'example.bam', package="ShowAlignment")
bam_df <- upload_bam(bam_file)
head(bam_df)

## -----------------------------------------------------------------------------
sam_file <- system.file('extdata', 'example.sam', package="ShowAlignment")
sam_df <- upload_sam(sam_file)
head(sam_df)

## -----------------------------------------------------------------------------
file <- system.file('extdata', 'example.bam', package="ShowAlignment")
show_alignment("GCATAACCCCTCTCTGAATCAATGAATCGCAAATCAGCCACTTTAATTAAGCTAAGCCCTTACTAGACCAATGGGACTTAAACCCGCAAACACTTAGTTAA",file, Hsapiens)

