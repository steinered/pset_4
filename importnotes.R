# instructions source https://crimebythenumbers.com/scrape-table.html

# load pdf as text
lopdf_text <- pdf_text("lopez_osorio_etal_2017.pdf") 

# separate and create table 1
table1 <- lopdf_text[[5]] %>% 
  strsplit(., "\n") %>% 
  .[[1]] %>% 
  trimws()
head(table1, 15)

# install java
# https://www.java.com/en/download/
# install "rJava" package

# download java

# download tabula-java
# https://github.com/tabulapdf/tabula-java/blob/master/README.md
# install "rJava" package
# install "tabulapdf" package (https://cran.r-project.org/web/packages/tabulapdf/readme/README.html)
# use install.packages("tabulapdf", repos = c("https://ropensci.r-universe.dev", "https://cloud.r-project.org"))
# now you can load library
library("tabulapdf")

# # establish pdf path
# studypdf <- "~/Documents/r_coding_eds/ppha_program_eval/pset4/lopez_osorio_etal_2017.pdf"
# 
# table1 <- extract_tables(studypdf, pages = 5)

f <- system.file("examples", "data.pdf", package = "tabulapdf")
out <- extract_tables(f)
out[[1]]






# used the following sources to determine method for extraction
# suggesting tabulapdf: https://www.r-bloggers.com/2024/04/tabulapdf-extract-tables-from-pdf-documents/
# instructions for downloading tabula, requires java download
# https://tabula.technology/




# issue arises as some wraparound text falsely indicates new rows
# # fix with for loop to create singular rows
# 
# # create table1list for storing fixed strings
# table1list <- c()
# # initialize placeholder for current row = "currentrow"
# currentrow <- ""
# 
# # fix the wraparound rows
# # for every line in the text file
# for (line in table1text) {
#   # if line contains a period/decimal ".", i.e. should be its own row, TRUE
#   if (str_detect(line, "\\.")) {
#     # store line as "currentrow"
#     # if "currentrow" already filled,
#     if(nchar(currentrow) > 0) {
#     # add prior currentrow to the fixed list
#     table1list <- c(table1list, 
#                     # and remove whitespaces (str_squish)
#                     str_squish(currentrow))
#     }
#     # then when currentrow is empty, start a new row/line
#     currentrow <- line
#   }
#   # if line does not contain "new row" text
#   else{
#     # add text to prior row
#     currentrow <- paste(currentrow, line)
#   }
# }
# 
# if(nchar(currentrow) > 0) {
#   table1list <- c(table1list, str_squish(currentrow))
# }
# 
# 
# head(table1list, 10)







```

```


# table1text is your input vector (lines from the PDF)
table1text <- table1text[11:49]

table1list <- c()
indicator_text <- ""  # to hold wrapped description
data_line <- ""       # to hold the line with numbers

# pattern for lines that include risk ratio [lower-upper]
rr_pattern <- "\\d+\\s+\\[[0-9.]+\\-"

for (line in table1text) {
  if (str_detect(line, rr_pattern)) {
    # if we already have a data line stored, finalize the previous row
    if (nchar(data_line) > 0) {
      full_row <- str_squish(paste(indicator_text, data_line))
      table1list <- c(table1list, full_row)
    }
    # now reset and store new row info
    indicator_text <- ""  # new description starts from scratch
    data_line <- line     # this is the row with numbers
  } else {
    # this line is a continuation of the indicator description
    indicator_text <- paste(indicator_text, line)
  }
}

# Add the final row after loop
if (nchar(data_line) > 0) {
  full_row <- str_squish(paste(indicator_text, data_line))
  table1list <- c(table1list, full_row)
}

# Result: one row per observation, with complete indicator name first
head(table1list, 10)



# create table1list for storing fixed strings
table1list <- c()
# initialize placeholder for current row = "currentrow"
currentrow <- ""

# fix the wraparound rows
# for every line in the text file
for (line in table1text) {
  # if line contains a period/decimal ".", i.e. should be its own row, TRUE
  if (str_detect(line, "\\.")) {
    full_line <- paste(currentrow, line)
    table1list <- c(table1list, str_squish(full_line))
    currentrow <- ""
    # # store line as "currentrow"
    # # if "currentrow" already filled,
    # if(nchar(currentrow) > 0) {
    #   # add prior currentrow to the fixed list
    #   table1list <- c(table1list, 
    #                   # and remove whitespaces (str_squish)
    #                   str_squish(currentrow))
    # }
    # # then when currentrow is empty, start a new row/line
    # currentrow <- line
  }
  # if line does not contain "new row" text
  else{
    # add text to prior row
    currentrow <- paste(currentrow, line)
  }
}

if(nchar(currentrow) > 0) {
  table1list <- c(table1list, str_squish(currentrow))
}


head(table1list, 10)



