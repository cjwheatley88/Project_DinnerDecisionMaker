library(dplyr)

library(tidyverse)

#dinner decision making tool; to aid in picking scrumptious favorites.

#create vector list of meal names.. IDEA - interface with a known service. I.e. TASTE.com DB. 

dinner_list <- c("Steak, Chips and Salad", "Homemade Pizza", "Spaghetti Bologna", 
            "Butter Chicken", "Sweet Potato Pockets", "Lamb Backstrap Salad",
            "Mexican Bowls", "Pesto Pasta", "Lamb Chops, Mash and Veggies",
            "chilli and cornbread", "risotto", "Poke Bowls", 
            "Reheat Meal", "Homemade Burgers")

takeout <- "Takeout"

new_recipe <- "New Recipe"

#Assign probabilities of drawing certain meals from the sample function.

#dinner_list majority of selections per fortnight, takeout @ once per week, new recipe @ once per month.

probabilities <- c((rep(1/14,times=length(dinner_list))),1/7, 1/28)

meal_data <- data.frame(dinners = c(dinner_list, takeout, new_recipe), probs = probabilities) %>%
  mutate(index = 1:length(dinners))

dinner_schedule <- sample(meal_data$index, 7, replace = FALSE, prob = probabilities)

dinner_schedule

meal_data$dinners[dinner_schedule]

#use index variable to match meals to ingredients. 

ingredients <- c("avocado", "asparagus", "bread_gluten_free", "bread", "bacon","butter","broccolini",
                 "carrots", "cheese", "cinnamon", "capsicum", "eggs", "eggplant", "hommus", "ham", "lemons",
                 "limes", "lettuce", "mozzarella", "milk", "milk_oat", "mushrooms", "onion_brown", 
                 "onion_red", "olives", "oil_cooking", "pasta", "pizza_bases", "pesto", "rocket",
                 "chorizo", "salami", "cauliflower", "chicken_breast", "chicken_thigh", "chicken_schnitzel",
                 "proscuitto", "pumpkin", "sour_cream", "lamb_chops", "pickled_ginger", "dried_shallots",
                 "cucumber", "baby_cos_lettuce")

#link ingredients to index numbers. In order to pull a grocery list from the weekly dinner_schedule.

#matrix - row names trialed as meal names or index for retrieval. Each meal will assign a 1 to it's req'd ingredient.

m <- matrix(nrow = length(ingredients), ncol = length(meal_data$dinners))

colnames(m) <- c(meal_data$dinners)

row.names(m) <- c(ingredients)

