
#select the women province table
women_province <- demographic %>% slice(14:22)

#count all the numbers
women_province <- mutate(women_province,
                         num_no_edu = round(no_education * number/100),
                         num_primary = round(primary * number/100),
                         num_secondary = round(secondary * number/100),
                         num_higher = round(higher * number/100)
)

#women no education
women_noeduage <- data.frame(age = women_province$background, gender = "female", education_level = "no education", sub_num = women_province$num_no_edu, total_number = women_province$number, share = women_province$no_education/100, stringsAsFactors = FALSE)

#women primary
women_primary <- data.frame(age = women_province$background, gender = "female", education_level = "primary", sub_num = women_province$num_primary, total_number = women_province$number, share = women_province$primary/100, stringsAsFactors = FALSE)

#women secondary
women_secondary <- data.frame(age = women_province$background, gender = "female", education_level = "secondary", sub_num = women_province$num_secondary, total_number = women_province$number, share = women_province$secondary/100, stringsAsFactors = FALSE)

#women higher
women_higher <- data.frame(age = women_province$background, gender = "female", education_level = "higher", sub_num = women_province$num_higher, total_number = women_province$number, share = women_province$higher/100, stringsAsFactors = FALSE)

women_noeduage$age <- factor(women_noeduage$age, levels = women_noeduage$age[order(women_noeduage$share)])
women_primary$age <- factor(women_primary$age, levels = women_primary$age[order(women_primary$share)])
women_secondary$age <- factor(women_secondary$age, levels = women_secondary$age[order(women_secondary$share)])
women_higher$age <- factor(women_higher$age, levels = women_higher$age[order(women_higher$share)])

women_province.plot <- rbind(women_noeduage, women_primary, women_secondary, women_higher)

#plot the graph
women_province.plot %>% 
  ggplot() +
  geom_bar(mapping = aes(x = age, y = sub_num , fill = education_level), stat = "identity", position = "fill") +
  labs(x = "Province",
       y = "Relative Proportion of Different Education levels",
       title = "Relative Proportion of Different Education Levels Each Province(Women)") +
  coord_flip()