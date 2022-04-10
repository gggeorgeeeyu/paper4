
#remove.packages(c("pdftools", "data.table"))
#install.packages('Rcpp', dependencies = TRUE)
#install.packages('pdftools', dependencies = TRUE)
#install.packages('data.table', dependencies = TRUE)
#install.packages("tidyverse")
#install.packages("janitor")



knitr::opts_chunk$set(echo = TRUE)

library(janitor)
library(pdftools)
library(purrr)
library(tidyverse)
library(stringi)



#read in pdf and page 44
paper = pdf_text("https://dhsprogram.com/pubs/pdf/FR86/FR86.pdf")
cat(paper[44])

#split the lines
page <- stri_split_lines(paper[[44]])[[1]]
page <- page[page != ""] #remove the empty lines
page <- page[-56] #remove the page number line

page_no_header <- page[8:length(page)] #select the data only
str_squish(page_no_header[1]) #compress the spaces
demographic <- tibble(all = page_no_header)#turn it into a table
demographic <- demographic %>% #name and split the columns
  mutate(all = str_squish(all)) %>%
  separate(col = all,
           into = c("background", "no_education", "primary", "secondary", "higher", "total", "number"),
           sep = " ",
           remove = TRUE,
           fill = "right",
           extra = "drop"
  )



#correct the wrong numbers

a = as.numeric(demographic$no_education)
b = as.numeric(demographic$primary)
c = as.numeric(demographic$secondary)
d = as.numeric(demographic$higher)
e = as.numeric(demographic$total)
f = as.numeric(demographic$number)

a[5] <- 11.7
b[5] <- 57.1
c[5] <- 27.0
d[5] <- 4.2
d[33] <- 11.6
e[5] <- 100.0
e[18] <- 100.0
e[27] <- 100.0
e[33] <- 100.0
f[5] <- 1286
f[33] <- 65
f[3] <- 2003
f[4] <- 1830
f[6] <- 1081
f[11:12] <- c(3604, 4417)
f[15:16] <- c(1588, 1075)
f[18] <- 1403
f[23] <- 8021

#replace the new columns
demographic$no_education <- a
demographic$primary <- b
demographic$secondary <- c
demographic$higher <- d
demographic$total <- e
demographic$number <- f
