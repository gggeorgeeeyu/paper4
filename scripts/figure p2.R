
#select the men age table
men_age <- demographic %>% slice(26:34)

#count all the numbers
men_age <- mutate(men_age,
                  num_no_edu = round(no_education * number/100),
                  num_primary = round(primary * number/100),
                  num_secondary = round(secondary * number/100),
                  num_higher = round(higher * number/100)
)

#men no education
men_noeduage <- data.frame(age = men_age$background, gender = "male", education_level = "no education", sub_num = men_age$num_no_edu, total_number =men_age$number, share = men_age$no_education/100, stringsAsFactors = FALSE)

#men primary
men_primary <- data.frame(age = men_age$background, gender = "male", education_level = "primary", sub_num = men_age$num_primary, total_number = men_age$number, share = men_age$primary/100, stringsAsFactors = FALSE)

#men secondary
men_secondary <- data.frame(age = men_age$background, gender = "male", education_level = "secondary", sub_num = men_age$num_secondary, total_number = men_age$number, share = men_age$secondary/100, stringsAsFactors = FALSE)

#men higher
men_higher <- data.frame(age = men_age$background, gender = "male", education_level = "higher", sub_num = men_age$num_higher, total_number = men_age$number, share = men_age$higher/100, stringsAsFactors = FALSE)

men_noeduage$age <- factor(men_noeduage$age, levels = men_noeduage$age[order(men_noeduage$share)])
men_primary$age <- factor(men_primary$age, levels = men_primary$age[order(men_primary$share)])
men_secondary$age <- factor(men_secondary$age, levels = men_secondary$age[order(men_secondary$share)])
men_higher$age <- factor(men_higher$age, levels = men_higher$age[order(men_higher$share)])

men_age.plot <- rbind(men_noeduage, men_primary, men_secondary, men_higher)

#plot the graph
men_age.plot %>% 
  ggplot() +
  geom_bar(mapping = aes(x = reorder(age, desc(sub_num)), y = sub_num , fill = education_level), stat = "identity", position = "fill") +
  labs(x = "Age Group",
       y = "Relative Proportion of Different Education levels",
       title = "Relative Proportion of Different Education Levels Each Age Group(Men)") +
  coord_flip()