# Data Processing 1


# Load Packages -----------------------------------------------------------

library(pdftools)
library(tm)


# Loading pdf as Corpus ----------------------------------------------------

# Get all names

file_names <- list.files(path = "data/PDF/",
                         pattern = ".pdf",
                         full.names = TRUE)

# Load in the data into a corpus

corp <- Corpus(URISource(file_names),
               readerControl = list(reader = readPDF))
