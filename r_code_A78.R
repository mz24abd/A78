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



#question 4 analysis

# Install dplyr 
install.packages("dplyr")

# Load dplyr
library(dplyr)
data <- data[, !is.na(colnames(data))]
colnames(data)

# Step 2: Fix column names
colnames(data) <- make.names(colnames(data), unique = TRUE)
colnames(data)
cat("Cleaned column names:\n")
print(colnames(data))

# Step 3: Manually Rename Columns (if needed)
# Adjust column names based on your dataset structure
colnames(data) <- c("State_FIPS", "Postal_Code", "State_Name", 
                    "Poverty_All_Ages", "CI_Lower_All_Ages", "CI_Upper_All_Ages",
                    "Poverty_Percent_All_Ages", "CI_Lower_Percent", "CI_Upper_Percent",
                    "Poverty_0_17", "CI_Lower_0_17", "CI_Upper_0_17",
                    "Poverty_Percent_0_17", "CI_Lower_Percent_0_17", "CI_Upper_Percent_0_17",
                    "Median_Household_Income", "CI_Lower_Income", "CI_Upper_Income",
                    "Poverty_0_4", "CI_Lower_0_4", "CI_Upper_0_4",
                    "Poverty_Percent_0_4", "CI_Lower_Percent_0_4", "CI_Upper_Percent_0_4")


data <- data %>%
  mutate(across(c(Poverty_All_Ages, Poverty_Percent_All_Ages, 
                  Poverty_0_17, Poverty_Percent_0_17, 
                  Median_Household_Income, Poverty_0_4, Poverty_Percent_0_4), as.numeric))


# Step 5: Perform Correlation Test
# Test relationship between Poverty Percent (All Ages) and Median Household Income
correlation_test <- cor.test(data$Poverty_Percent_All_Ages, data$Median_Household_Income, use = "complete.obs")

# Display correlation results
cat("\nCorrelation Test Results:\n")
print(correlation_test)


# Step 6: Visualize the Relationship
ggplot(data, aes(x = Median_Household_Income, y = Poverty_Percent_All_Ages)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Relationship between Poverty Percentage and Median Household Income",
       x = "Median Household Income",
       y = "Poverty Percentage (All Ages)") +
  theme_minimal()
ggsave("appropriate_plot.png", plot = plot, width = 8, height = 6)
