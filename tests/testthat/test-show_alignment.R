#context("show_alignment")

test_that("Show the alignment of mapped reads", {
  input <- "GCATAACCCCTCTCTGAATCAATGAATCGCAAATCAGCCACTTTAATTAAGCTAAGCCCTTACTAGACCAATGGGACTTAAACCCGCAAACACTTAGTTAA"
  file <- system.file('extdata', 'example.bam', package="ShowAlignment")
  expected <- cat(paste0( "\n   ", "Pos: ", "chr1  630765-630865", "\n ", "Cigar: ", "22M1D4M1I74M" , "\n   ","Ref: ", "GCAAAACCCCACTCTGCATCAACTGA-ACGCAAATCAGCCACTTTAATTAAGCTAAGCCCTTACTAGACCAATGGGACTTAAACCCACAAACACTTAGTTAA", "\n  ", "Read: ", "GCATAACCCCTCTCTGAATCAA-TGAATCGCAAATCAGCCACTTTAATTAAGCTAAGCCCTTACTAGACCAATGGGACTTAAACCCGCAAACACTTAGTTAA"))
  expect_equal(show_alignment(input, file, Hsapiens), expected)
})

test_that("returns error if not recognized as a sequence", {
  input <- "I am not a sequence"
  file <- system.file('extdata', 'example.bam', package="ShowAlignment")
  expect_error(show_alignment(input, file, Hsapiens))
})


