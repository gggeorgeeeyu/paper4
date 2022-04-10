
#new data set
demographic2 = demographic

#change na to null
demographic2 <- sapply(demographic2, as.character)
demographic2[is.na(demographic2)] <- " "

#build the table
knitr::kable(demographic2, caption = "Level of education by background characteristics(shown in percentage)")
