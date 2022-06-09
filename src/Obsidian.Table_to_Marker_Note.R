#!/usr/bin/env Rscript

rm(list = ls())
options(stringsAsFactors = F)

library(optparse)

# Parse arguments
option_list <- list(
  make_option(
    opt_str = c("--INPUTFILE"),
    action = "store",
    type = "character",
    default = NULL,
    help = "Path to input file",
    metavar = "character"
  ),
  make_option(
    opt_str = c("--OUTPUTDIR"),
    action = "store",
    type = "character",
    default = NULL,
    help = "Path to output directory",
    metavar = "character"
  )
)

opt_parser = OptionParser(option_list = option_list)
opt = parse_args(opt_parser)

inputfile <- as.character(opt$INPUTFILE)
outputdir <- as.character(opt$OUTPUTDIR)

# --- #

ReQ_packages = c("data.table", "dplyr", "tibble", "stringr", "magrittr", "tidyr")

for (pack in ReQ_packages) {
  if(pack %in% rownames(installed.packages()) == FALSE) {
    BiocManager::install(pack)
    suppressPackageStartupMessages(library(pack, character.only = TRUE))
  } else {
    library(pack, character.only = TRUE)
  }
}

# --- #

input <- fread(inputfile, data.table = FALSE, header = TRUE, encoding = "Latin-1")
input$`subtype-source-notes` <- paste0(input$`subtype`, ';', input$`source`, ';', input$`notes`)

for (gene in unique(input$`name`)) {
  
  tmp <- input[input$`name` == gene,]
  
  if (all(tmp$update == TRUE)) {
    
    tmp[is.na(tmp$`mm-gene`), "mm-gene"] <- ""
    tmp[is.na(tmp$`hs-gene`), "hs-gene"] <- ""
    tmp[is.na(tmp$`common-name`), "common-name"] <- ""
    tmp[is.na(tmp$`tumor`), "tumor"] <- ""
    
    print(gene)
    fileConn<-file(paste0(outputdir, gene, ".md"))
    
    writeLines(c("---",
                 paste0("aliases: [", paste(unique(tmp$`aliases`), collapse = ", "), "]"),
                 paste0('mm-gene: "', unique(tmp$`mm-gene`), '"'),
                 paste0('hs-gene: "', unique(tmp$`hs-gene`), '"'),
                 paste0('common-name: "', unique(tmp$`common-name`), '"'),
                 paste0('celltype:'),
                 paste0('- "', unique(tmp$`celltype`), '"'),
                 paste0('subtype-source-notes:'),
                 paste0('- "', inp.test$`subtype-source-notes`, '"'),
                 paste0('tumor: "', paste(unique(tmp$`tumor`), collapse = ";"), '"'),
                 "---",
                 "",
                 "Links: [[000 Vault TOC]], [[030 Gene Cards]]",
                 "#marker",
                 "",
                 "---",
                 unique(tmp$`main-body`)
    ), fileConn)
    
    close(fileConn)
    
  }
}

