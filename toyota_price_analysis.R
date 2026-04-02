#Programming 1 - Assignment 4
#Your name(s): Group 9 - Mike Johnson | Ryan Mathis


# The file Toyota4.csv includes data for 1000 used Toyota Corollas, 
# including their prices and specification information:

#Price (in dollars)
#Age (in months)
#Mileage 
#Horse_Power
#Metallic_Color (1=yes, 0=no)
#Automatic (1=yes, 0=no)
#CC (cylinder volume)
#Doors
#Weight (in kg)
#Fuel Type (diesel, petrol, CNG)


# Load "Toyota4.csv" and save it as carsData.
# Load any packages that you may use for this assignment
carsData = read.csv("Toyota4.csv")

library(tidyverse)
library(stargazer) 


#Q1:
# Identify the variable(s) with missing values.
# Locate and replace those values with the mean of non-missing values.

# Check which variables have missing values
apply(carsData, 2, anyNA)

# Locate the missing values in Mileage
missing_mileage = which(is.na(carsData$Mileage))

# Replace missing values in Mileage with mean
mean_mileage = mean(carsData$Mileage, na.rm = TRUE)
carsData$Mileage[missing_mileage] = mean_mileage


#Q2:
# Summarize the fuel type variable using a frequency table and a plot.
# Return the name of the most common fuel type category.

# Frequency table of fuel type
freq_fuel_type = table(carsData$Fuel_Type)
freq_fuel_type  

# Plot fuel type frequency
barplot_fuel_type = 
  carsData %>% 
  ggplot(aes(Fuel_Type)) +
  geom_bar()

barplot_fuel_type

# Most common fuel type category
mostcommon_fuel_type = which.max(freq_fuel_type)
mostcommon_fuel_type

#Q3:
# Create a boxplot that compares the distribution of price across different fuel types.
# Also, write a code that calculates the average price for each of these fuel type categories.
# Which fuel category has the highest average price? 
# (write a code that returns both the name and the average price of this category)

# Boxplot comparing distribution of price across different fuel types.
boxplot_price = 
  carsData %>% 
  ggplot(aes(Fuel_Type, Price)) +
  geom_boxplot()

boxplot_price

# Average price for each fuel type
fuel_type_avg_price = 
  carsData %>% 
  group_by(Fuel_Type) %>% 
  summarise(Avg_Price = mean(Price))

fuel_type_avg_price

# Fuel category with highest average price
highest_avg_price = fuel_type_avg_price[which.max(fuel_type_avg_price$Avg_Price),]
highest_avg_price


#Q4:
# Create two scatterplots: Price (y-axis) vs. Age (x-axis), Price (y-axis) vs. Mileage (x-axis)
# In an attempt to know which variable (Age or Mileage) is more strongly correlated with price,
# report the correlation coefficient for both.

# Scatterplot: Age vs Price
plot_age_price = 
  carsData %>% 
  ggplot(aes(Age, Price)) + #Dimensions
  geom_point() + # Viz
  
  # Labels
  labs(
    x = "Age",
    y = "Price",
    title = "Age vs Price"
  )

plot_age_price

# Scatterplot: Mileage vs Price
plot_mileage_price = 
  carsData %>% 
  ggplot(aes(Mileage, Price)) + #Dimensions
  geom_point() + # Viz
  
  # Labels
  labs(
    x = "Mileage",
    y = "Price",
    title = "Mileage vs Price"
  )

plot_mileage_price

# Correlation coefficients
cor_age_price = cor(carsData$Age, carsData$Price)
cor_mileage_price = cor(carsData$Mileage, carsData$Price)

cat("Correlation coefficient betweeen Age and Price:", cor_age_price, "\n")
cat("Correlation coefficient betweeen Mileage and Price:", cor_mileage_price, "\n")



#Q5:
# Detect and remove outliers in terms of Price using the z-score method (z > 3 or z < -3).
# Write a code to return the number of outliers and save the cleaned data as carsUpdated.
# Note: While there are various methods for detecting outliers, use the z-score approach for this exercise.

# Create a column that caluclates the z-score for Price
carsData = 
  carsData %>% 
  mutate(price_z = (Price - mean(Price)) / sd(Price))

# Identify outliers
z_outliers = 
  carsData %>% 
  filter(price_z > 3 | price_z < -3)

count_outliers = nrow(z_outliers)

cat("Number of outliers:", count_outliers)

# Create carsUpdated that removes outliers
carsUpdated = 
  carsData %>% 
  filter(price_z <= 3 & price_z >= -3)



#Q6: 
# Run a simple linear regression of price using age as the predictor. (use the updated dataset)
# Save the results as regAge. Write a code that returns the summary of the results.
regAge = lm(Price~Age, carsUpdated)
summary(regAge)



#Q7: 
# Run a simple linear regression of price using mileage as the predictor. (use the updated dataset)
# Save the results as regMileage. Write a code that returns the summary of the results.
regMileage = lm(Price~Mileage, carsUpdated)
summary(regMileage)



#Q8: 
# Run a multiple linear regression of price using both age and mileage as predictors. (use the updated dataset)
# Save the results as regBoth. Write a code that returns the summary of the results.
regBoth = lm(Price~Age+Mileage, carsUpdated)
summary(regBoth)


#Q9:
# Create a table that compares the two regression models in terms of residual standard error and adjusted r-squares. 
# (Note: you can do so by building a dataframe of the desired outputs or using stargazer function. 
# In either case, make sure reach row/column is labeled accordingly.)
stargazer(regAge,regMileage, regBoth, type="text",
          dep.var.caption = "", dep.var.labels.include = T,
          report = "vc*", df = F, model.numbers = F,single.row = T,
          keep.stat = c("ser","rsq","adj.rsq"),
          column.labels = c("Reg w Age","Reg w Mileage", "Multiple Regression"))

