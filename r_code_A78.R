data <- read.csv("dataset/est13us.csv") #Load the Dataset into RStudio
head(data)        # View the first few rows
str(data)         # View the structure of the dataset
summary(data)     # View summary statistics

# To extract all column headers and the first two rows of our dataset in R

# Get column headers
col_headers <- colnames(data)
print("Column Headers:")
print(col_headers)

# Get the first two rows
first_two_rows <- data[1:2, ]
print("First Two Rows:")
print(first_two_rows)

# end
# To extract with tab separated dataset in R

# Get column headers
col_headers <- colnames(data)
cat("Column Headers (Tab-Separated):\n")
cat(paste(col_headers, collapse = "\t"), "\n\n")

# Get the first two rows
first_two_rows <- data[1:2, ]
cat("First Two Rows (Tab-Separated):\n")
apply(first_two_rows, 1, function(row) cat(paste(row, collapse = "\t"), "\n"))

# end










#report work

#question 3- visualisation
# Load required packages 
install.packages("ggplot2")
# Load necessary libraries
library(ggplot2)
# Inspect column names to verify
colnames(data)

# Clean the data (update these column names if needed)
data$Median_Household_Income <- as.numeric(data$Median.Household.Income) # Adjust column name
data$Poverty_Percent <- as.numeric(data$Unnamed..6) # Adjust column name based on your dataset
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