# Import Data from:
# https://www.bk.admin.ch/bk/de/home/dokumentation/abstimmungsbuechlein.html

# Load Packages -----------------------------------------------------------

library(rvest)
library(httr)
library(stringr)

# Scrape the links to the PDF's -------------------------------------------

url <- "https://www.bk.admin.ch/bk/de/home/dokumentation/abstimmungsbuechlein.html"

# Get all links and names

links_all <- read_html(url) %>%
  html_nodes(., "a")%>%
  html_attr("href")

names_all <- read_html(url) %>%
  html_nodes(., "a")%>%
  html_text()



# Cleaning Names ----------------------------------------------------------


names_pdf <- stringr::str_subset(names_all,
                                 "Erläuterung") 
names_pdf <- stringr::str_replace_all(names_pdf,
                                      "Erläuterung", "Erlaeuterung")
names_pdf <- stringr::str_replace_all(names_pdf,
                                      " ", "_")


# Prepare Links -----------------------------------------------------------

links_pdf_messy <- str_subset(links_all,
                              ".pdf") # should be 140 (18.12.2024)

links_pdf <- paste0("https://www.bk.admin.ch",
                    links_pdf_messy)

# Save PDF's --------------------------------------------------------------

for (i in seq_along(links_pdf)) {
  pdf_url <- links_pdf[i]
  file_name <- paste0("data/PDF/", names_pdf[i], ".pdf") 
  
  tryCatch({
    GET(pdf_url, write_disk(file_name, overwrite = TRUE))
    cat("Downloaded:", file_name, "\n")
  }, 
  error = function(e) {
    cat("Error downloading:", pdf_url, "\n")
  })
}


