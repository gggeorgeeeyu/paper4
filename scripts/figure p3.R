
#select the women region table
women_region <- demographic %>% slice(11:12)

#count all the numbers
women_region <- mutate(women_region,
                       num_no_edu = round(no_education * number/100),
                       num_primary = round(primary * number/100),
                       num_secondary = round(secondary * number/100),
                       num_higher = round(higher * number/100)
)

#women no education
women_noeduage <- data.frame(age = women_region$background, gender = "female", education_level = "no education", sub_num = women_region$num_no_edu, total_number = women_region$number, share = women_region$no_education/100, stringsAsFactors = FALSE)

#women primary
women_primary <- data.frame(age = women_region$background, gender = "female", education_level = "primary", sub_num = women_region$num_primary, total_number = women_region$number, share = women_region$primary/100, stringsAsFactors = FALSE)

#women secondary
women_secondary <- data.frame(age = women_region$background, gender = "female", education_level = "secondary", sub_num = women_region$num_secondary, total_number = women_region$number, share = women_region$secondary/100, stringsAsFactors = FALSE)

#women higher
women_higher <- data.frame(age = women_region$background, gender = "female", education_level = "higher", sub_num = women_region$num_higher, total_number = women_region$number, share = women_region$higher/100, stringsAsFactors = FALSE)

women_noeduage$age <- factor(women_noeduage$age, levels = women_noeduage$age[order(women_noeduage$share)])
women_primary$age <- factor(women_primary$age, levels = women_primary$age[order(women_primary$share)])
women_secondary$age <- factor(women_secondary$age, levels = women_secondary$age[order(women_secondary$share)])
women_higher$age <- factor(women_higher$age, levels = women_higher$age[order(women_higher$share)])

women_region.plot <- rbind(women_noeduage, women_primary, women_secondary, women_higher)

#plot the graph
women_region.plot %>% 
  ggplot() +
  geom_bar(mapping = aes(x = age, y = sub_num , fill = education_level), stat = "identity", position = "fill") +
  labs(x = "Region",
       y = "Relative Proportion of Different Region",
       title = "Relative Proportion of Different Education Levels Each Region(Women)") +
  coord_flip()
