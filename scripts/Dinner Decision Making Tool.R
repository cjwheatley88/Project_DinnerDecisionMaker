library(dplyr)
library(tidyverse)

meal_database <- c("Steak, Chips and Salad", "Homemade Pizza", "Spaghetti Bologna", 
            "Butter Chicken", "Sweet Potato Pockets", "Lamb Backstrap Salad",
            "Mexican Bowls", "Pesto Pasta", "Lamb Chops, Mash and Veggies",
            "chilli and cornbread", "risotto", "Poke Bowls", 
            "Reheat Meal", "Homemade Burgers", "One Pot Chicken","Chicken Schnitzel",
            "Bacon and Blue Cheese Pie")

#Frequency of meals set by probabilities.

probabilities <- c((rep(1/14,times=length(meal_database))),1/7, 1/28)

meal_data <- data.frame(dinners = c(meal_database, takeout, new_recipe), probs = probabilities) %>%
  mutate(index = 1:length(dinners))

dinner_schedule <- sample(meal_data$index, 7, replace = FALSE, prob = probabilities)

dinner_schedule #sampled index list

meal_data$dinners[dinner_schedule] #converted to meal list

# Testing probability distribution.

test <- data.frame(meals = sample(meal_data$dinners, 10000, replace = TRUE, prob = probabilities))

test %>% ggplot() +
  geom_histogram(aes(meals), stat = "count") +
  theme(axis.text.x = element_text(angle = -90))

#Intuitively feels okay.

ingredients <- c("avocado", "asparagus", "bread_gluten_free", "bread", "bacon","butter",
                 "broccolini","carrots", "cheese", "cinnamon", "capsicum", "eggs",
                 "eggplant", "hommus", "ham", "lemons", "limes", "lettuce", "mozzarella",
                 "milk", "milk_oat", "mushrooms", "onion_brown", "onion_red", "olives", 
                 "oil_cooking", "pasta", "pizza_bases", "pesto", "rocket", "chorizo", "salami",
                 "cauliflower", "chicken_breast", "chicken_thigh", "chicken_schnitzel",
                 "proscuitto", "pumpkin", "sour_cream", "lamb_chops", "pickled_ginger", 
                 "dried_shallots", "cucumber", "baby_cos_lettuce")

#matrix - row names trialed as meal names or index for retrieval. Each meal will assign a 1 to it's req'd ingredient.

m <- matrix(nrow = length(ingredients), ncol = length(meal_data$dinners))

colnames(m) <- c(meal_data$dinners)

row.names(m) <- c(ingredients)

#link ingredients to meals; to assist in pulling a grocery list.

