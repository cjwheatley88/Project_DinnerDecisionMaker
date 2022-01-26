library(dplyr)
library(tidyverse)

meal_database <- c("Steak, Chips and Salad", "Homemade Pizza", "Spaghetti Bologna", 
            "Butter Chicken", "Sweet Potato Pockets", "Lamb Backstrap Salad",
            "Mexican Bowls", "Pesto Pasta", "Lamb Chops, Mash and Veggies",
            "Chilli and Cornbread", "Risotto", "Poke Bowls", 
            "Reheat Meal", "Homemade Burgers", "One Pot Chicken","Chicken Schnitzel",
            "Bacon and Blue Cheese Pie")

takeout <- "Takeout"

new_recipe <- "New Recipe"

#Frequency of meals set by probabilities.

probabilities <- c((rep(1/14,times=length(meal_database))),1/7, 1/28)

meal_data <- data.frame(meals = c(meal_database, takeout, new_recipe),
                        probability = probabilities) %>%
                        mutate(index = 1:length(meals))

dinner_schedule <- sample(meal_data$index, 7, replace = FALSE, prob = probabilities)

dinner_schedule #sampled index list

dinners <- meal_data$meals[dinner_schedule] #converted to list of meals

dinners

# test and plot probability distribution.

test <- data.frame(meals = sample(meal_data$meals, 10000, replace = TRUE, prob = probabilities))

test %>% ggplot() +
  geom_histogram(aes(meals), stat = "count") +
  theme(axis.text.x = element_text(angle = -90)) +
  ggtitle("Meal Sampling Distribution")

#Intuitively feels okay.

ingredients <- c("avocado", "asparagus", "bread_gluten_free", "bread", "bacon","butter",
                 "broccolini","carrots", "cheese", "cinnamon", "capsicum", "eggs",
                 "eggplant", "hommus", "ham", "lemons", "limes", "lettuce", "mozzarella",
                 "milk", "milk_oat", "mushrooms", "onion_brown", "onion_red", "olives", 
                 "oil_cooking", "pasta", "pizza_bases", "pesto", "rocket", "chorizo", "salami",
                 "cauliflower", "chicken_breast", "chicken_thigh", "chicken_schnitzel",
                 "proscuitto", "pumpkin", "sour_cream", "lamb_chops", "pickled_ginger", 
                 "dried_shallots", "cucumber", "baby_cos_lettuce","steak","tomatoes",
                 "oven_chips","pizza_bases","cheese_mozzarella", "tomato_paste","pepperoni",
                 "beef_mince","garlic","spaghetti","bolognese_sauce","tinned_baby_roma_tomatoes")

#Build matrix with m x n dimensions, m/rows = ingredients and n/columns = meals.

m <- matrix(nrow = length(ingredients), ncol = length(meal_data$meals))

colnames(m) <- c(meal_data$meals)

row.names(m) <- c(ingredients)

#This is the painful part... link ingredients to meals; to assist in pulling a grocery list.
#Assigning a binary indicator = 1; to relevant ingredients with each meal.

#steak chips and salad
m[c("rocket","steak","tomatoes","onion_red","oven_chips","avocado"),"Steak, Chips and Salad"] <- 1

#Homemade Pizza
m[c("pizza_bases","pumpkin","olives","cheese_mozzarella","tomato_paste","pepperoni"),"Homemade Pizza"] <- 1

#Spaghetti Bologna
m[c("beef_mince","onion_brown","garlic","spaghetti","bolognese_sauce","tinned_baby_roma_tomatoes"), "Spaghetti Bologna"] <- 1



#ingredients list pulled from sample and matrix.

