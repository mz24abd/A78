data <- read.csv("dataset/est13us.csv") #Load the Dataset into RStudio
head(data)        # View the first few rows
str(data)         # View the structure of the dataset
summary(data)     # View summary statistics


#question 3- visualisation
# Load required packages 
install.packages("ggplot2")
# Load necessary libraries
library(ggplot2)


# Clean the data
data$Median_Household_Income <- as.numeric(data$Median.Household.Income)
data$Poverty_Percent <- as.numeric(data$Poverty.Percent..All.Ages)
clean_data <- na.omit(data[, c("Median_Household_Income", "Poverty_Percent")])

# Create the scatterplot with regression line
ggplot(clean_data, aes(x = Median_Household_Income, y = Poverty_Percent)) +
  geom_point(color = "blue", alpha = 0.6) +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(
    title = "Relationship Between Median Household Income and Poverty Percent",
    x = "Median Household Income (USD)",
    y = "Poverty Percent (%)",
    caption = "Data source: est13us.csv"
  ) +
  theme_minimal()
