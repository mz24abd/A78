# Install required packages section
install.packages("ggplot2")
install.packages("dplyr")
#end section

# Load required packages section
library(ggplot2)
library(dplyr)
#end section

#Loading Dataset section
data <- read.csv("dataset/est13us.csv") #Load the Dataset into RStudio
head(data)        # View the first few rows
str(data)         # View the structure of the dataset
summary(data)     # View summary statistics
#end section

# Extract all column headers and the first two rows section
col_headers <- colnames(data)# Get column headers
print("Column Headers:")# Output message
print(col_headers)# Print column headers
first_two_rows <- data[1:2, ]# Get the first two rows
print("First Two Rows:")# Output message
print(first_two_rows) # Print first two rows
# end section

# Extract with tab separated sectoin
cat(paste(col_headers, collapse = "\t"), "\n\n")# Get the data/columns with tab separated
first_two_rows <- data[1:2, ]# Get the first two rows
cat("First Two Rows (Tab-Separated):\n")# Output message
apply(first_two_rows, 1, function(row) cat(paste(row, collapse = "\t"), "\n"))
# end section

# Analysis and visualization section
data <- data[, !is.na(colnames(data))]# Clean data from all column names 'NA'
cat("Cleaned column names:\n")# Output message
print(colnames(data))# Print columns names
# Adjust column names based on dataset structure
colnames(data) <- c("State_FIPS", "Postal_Code", "State_Name", 
                    "Poverty_All_Ages", "CI_Lower_All_Ages", "CI_Upper_All_Ages",
                    "Poverty_Percent_All_Ages", "CI_Lower_Percent", "CI_Upper_Percent",
                    "Poverty_0_17", "CI_Lower_0_17", "CI_Upper_0_17",
                    "Poverty_Percent_0_17", "CI_Lower_Percent_0_17", "CI_Upper_Percent_0_17",
                    "Median_Household_Income", "CI_Lower_Income", "CI_Upper_Income",
                    "Poverty_0_4", "CI_Lower_0_4", "CI_Upper_0_4",
                    "Poverty_Percent_0_4", "CI_Lower_Percent_0_4", "CI_Upper_Percent_0_4")
# Transform columns data as numeric
data <- data %>% mutate(across(c(Poverty_All_Ages, Poverty_Percent_All_Ages, 
                  Poverty_0_17, Poverty_Percent_0_17, 
                  Median_Household_Income, Poverty_0_4, Poverty_Percent_0_4), as.numeric))
# Test relationship between Poverty Percent (All Ages) and Median Household Income
correlation_test <- cor.test(data$Poverty_Percent_All_Ages, data$Median_Household_Income, use = "complete.obs")
cat("\nCorrelation Test Results:\n")# Output message
print(correlation_test)# Display correlation results
# Visualize the Relationship
ggplot(data, aes(x = Median_Household_Income, y = Poverty_Percent_All_Ages)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Relationship between Poverty Percentage and Median Household Income",
       x = "Median Household Income",
       y = "Poverty Percentage (All Ages)") +
  theme_minimal()
# To save the Plot picture into project
ggsave("appropriate_plot.png", plot = plot, width = 8, height = 6)
#end section
