# create empty data frame
university_costs = data.frame(matrix(ncol=3, nrow=285))
colnames(university_costs) = c('price_range', 'material', 'level')

# write function that will use loop to enter student data into data frame
fill_in_df = function(price_range, material, level, count) {
  university_costs = data.frame(matrix(ncol=3, nrow=length(count)))
  colnames(university_costs) = c('price_range', 'material', 'level')
  
  for(i in 1:count){
    university_costs[i,'price_range'] <- price_range
    university_costs[i,'material'] <- material
    university_costs[i,'level'] <- level
  }
  return(university_costs)
}

# run function on collected textbook data and combine to smaller data frame
textbooks_1 = fill_in_df('$0', 'textbook', 'undergraduate', 27)
textbooks_2 = fill_in_df('$1-$99', 'textbook', 'undergraduate', 25)
textbooks_3 = fill_in_df('$100-$199', 'textbook', 'undergraduate', 39)
textbooks_4 = fill_in_df('$200-$299', 'textbook', 'undergraduate', 21)
textbooks_5 = fill_in_df('$300-$399', 'textbook', 'undergraduate', 12)
textbooks_6 = fill_in_df('$400-$499', 'textbook', 'undergraduate', 2)
textbooks_10 = fill_in_df('$800+', 'textbook', 'undergraduate', 4)

textbook_costs = rbind(textbooks_1, textbooks_2, textbooks_3, textbooks_4, textbooks_5, textbooks_6, textbooks_10)

textbooks_11 = fill_in_df('$0', 'textbook', 'graduate', 9)
textbooks_12 = fill_in_df('$1-$99', 'textbook', 'graduate', 4)
textbooks_13 = fill_in_df('$100-$199', 'textbook', 'graduate', 4)
textbooks_14 = fill_in_df('$200-$299', 'textbook', 'graduate', 4)
textbooks_16 = fill_in_df('$400-$499', 'textbook', 'graduate', 1)
textbooks_17 = fill_in_df('$500-$599', 'textbook', 'graduate', 1)
textbooks_18 = fill_in_df('$600-$699', 'textbook', 'graduate', 1)
textbooks_20 = fill_in_df('$800+', 'textbook', 'graduate', 1)

textbook_costs_2 = rbind(textbooks_11, textbooks_12, textbooks_13, textbooks_14, textbooks_16, textbooks_17, textbooks_18, textbooks_20)

# run function on collected homework access code data and combine to smaller data frame
hw_access_1 = fill_in_df('$0', 'homework access code', 'undergraduate', 33)
hw_access_2 = fill_in_df('$1-$99', 'homework access code', 'undergraduate', 38)
hw_access_3 = fill_in_df('$100-$199', 'homework access code', 'undergraduate', 32)
hw_access_4 = fill_in_df('$200-$299', 'homework access code', 'undergraduate', 6)
hw_access_5 = fill_in_df('$300-$399', 'homework access code', 'undergraduate', 1)
hw_access_6 = fill_in_df('$400-$499', 'homework access code', 'undergraduate', 3)

hw_access_costs = rbind(hw_access_1, hw_access_2, hw_access_3, hw_access_4, hw_access_5, hw_access_6)

hw_access_11 = fill_in_df('$0', 'homework access code', 'graduate', 11)
hw_access_12 = fill_in_df('$1-$99', 'homework access code', 'graduate', 3)
hw_access_13 = fill_in_df('$100-$199', 'homework access code', 'graduate', 2)
hw_access_20 = fill_in_df('$800+', 'homework access code', 'graduate', 1)

hw_access_costs_2 = rbind(hw_access_11, hw_access_12, hw_access_13, hw_access_20)

# combine smaller textbook and homework access code cost data frames into university costs data frame
university_costs = rbind(textbook_costs, textbook_costs_2, hw_access_costs, hw_access_costs_2)

# write data frame to a csv file
write.csv(university_costs, file='university_textbook_and_homework_costs.csv', sep='', col.names=TRUE, row.names=FALSE)

# check csv file using read_csv()
library(tidyverse)
getwd()
university_costs = read_csv('university_textbook_and_homework_costs.csv')
