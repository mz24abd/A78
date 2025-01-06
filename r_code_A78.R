# Install required packages
install.packages("ggplot2")
install.packages("dplyr")

# Load necessary libraries
library(dplyr)    # For data manipulation
library(ggplot2)  # For visualization

# Load the dataset
data <- read.csv("dataset/est13us.csv")

# Clean column names to remove invalid characters and make them easier to work with
colnames(data) <- make.names(colnames(data), unique = TRUE)

# Inspect cleaned column names
print(colnames(data))  # Ensure the required columns exist

# Select and rename relevant columns for analysis
# Replace "All.Ages" with the correct column name if needed
data <- data %>%
  select(Poverty.Percent = All.Ages, Median.Household.Income) %>%
  mutate(
    Poverty.Percent = as.numeric(Poverty.Percent),            # Convert to numeric
    Median.Household.Income = as.numeric(Median.Household.Income)  # Convert to numeric
  )

# Remove rows with missing or invalid data
data <- na.omit(data)

# Perform Pearson correlation test
correlation_test <- cor.test(data$Poverty.Percent, data$Median.Household.Income, method = "pearson")

# Print correlation test results to the console and log file
print(correlation_test)

# Save correlation results to a log file
sink("Rscript.log")  # Redirect output to log file
print("Correlation Test Results:")
print(correlation_test)
sink()  # End redirection

# Create scatter plot with regression line
plot <- ggplot(data, aes(x = Median.Household.Income, y = Poverty.Percent)) +
  geom_point(color = "blue") +                        # Data points
  geom_smooth(method = "lm", se = TRUE, color = "red") +  # Regression line
  labs(
    title = "Relationship Between Median Household Income and Poverty Percent",
    x = "Median Household Income",
    y = "Poverty Percent (All Ages)"
  ) +
  theme_minimal()  # Clean theme for better visuals

# Display the plot
print(plot)

# Save the plot to a file
ggsave("Income_vs_Poverty_Plot.png", plot = plot)