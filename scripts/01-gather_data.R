

library(janitor)
library(pdftools)
library(purrr)
library(tidyverse)
library(stringi)
```

#read in pdf and page 44
paper = pdf_text("https://dhsprogram.com/pubs/pdf/FR86/FR86.pdf")
cat(paper[44])