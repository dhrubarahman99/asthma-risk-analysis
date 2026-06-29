#"Data Cleaning"_#

# Read the CSV file into a data frame and view it
assignment_data <- read.csv("C:/Users/user/Documents/asthma_dataset.csv", header = TRUE)
View(assignment_data)

# Select specific columns from the data frame
selected_data <- assignment_data[, c("Ethnicity", "PhysicalActivity", "PollenExposure", "FamilyHistoryAsthma", "Diagnosis")]
View(selected_data)

# Remove special characters from specific columns
selected_data$PhysicalActivity <- gsub("[_@-]", "", selected_data$PhysicalActivity)
selected_data$PollenExposure <- gsub("[_@-]", "", selected_data$PollenExposure)
View(selected_data)

# Convert columns to numeric and round Ethnicity
selected_data = transform(selected_data, Ethnicity = as.numeric(Ethnicity))
selected_data$Ethnicity = round(selected_data$Ethnicity, digits = 0)
selected_data = transform(selected_data, PhysicalActivity = as.numeric(PhysicalActivity))
selected_data = transform(selected_data, FamilyHistoryAsthma = as.numeric(FamilyHistoryAsthma))
selected_data = transform(selected_data, PollenExposure = as.numeric(PollenExposure))

# View the transformed data
View(selected_data)

# Remove rows with missing values
#selected_data <- na.omit(selected_data)

#Give Summery of all the Selected Data
summary (selected_data) 

##

#_Removing "NA" Values of "Physical Activity"#
# Display rows where 'PhysicalActivity' column has NA values
na_rows_physical_activity <- selected_data[is.na(selected_data$PhysicalActivity), ]

# View the filtered rows
View(na_rows_physical_activity)

# Access the 'PhysicalActivity' column from the selected data
selected_data$PhysicalActivity

# Calculate the mean of the 'PhysicalActivity' column, ignoring NA values(Full set)
mean_physical_activity <- mean(selected_data$PhysicalActivity, na.rm = TRUE)
print(mean_physical_activity)

# Replace NA values in the 'PhysicalActivity' column with the calculated mean
selected_data$PhysicalActivity[is.na(selected_data$PhysicalActivity)] <- mean_physical_activity

# View the updated data
View(selected_data)

# Check if there are any NA values left in the 'PhysicalActivity' column
remaining_na_physical_activity <- sum(is.na(selected_data$PhysicalActivity))
print(remaining_na_physical_activity)

##

#_Removing "NA" Values of "Pollen Exposure"#
# Display rows where 'PollenExposure' column has NA values
na_rows_pollen_exposure <- selected_data[is.na(selected_data$PollenExposure), ]

# View the filtered rows
View(na_rows_pollen_exposure)

# Access the 'PollenExposure' column from the selected data
selected_data$PollenExposure

# Calculate the mean of the 'PollenExposure' column, ignoring NA values(Full set)
mean_pollen_exposure <- mean(selected_data$PollenExposure, na.rm = TRUE)
print(mean_pollen_exposure)

# Replace NA values in the 'PollenExposure' column with the calculated mean
selected_data$PollenExposure[is.na(selected_data$PollenExposure)] <- mean_pollen_exposure

# View the updated data
View(selected_data)

# Check if there are any NA values left in the 'PhysicalActivity' column
remaining_na_pollen_exposure <- sum(is.na(selected_data$PollenExposure))
print(remaining_na_pollen_exposure)

#_#

#"Corrections 1 "#

# Check the structure of the entire data frame before changes
str(selected_data)

# Convert columns to numeric and round the 'Ethnicity' column
selected_data <- transform(selected_data, Ethnicity = as.numeric(Ethnicity))
selected_data <- transform(selected_data, PhysicalActivity = as.numeric(PhysicalActivity))
selected_data <- transform(selected_data, FamilyHistoryAsthma = as.numeric(FamilyHistoryAsthma))
selected_data <- transform(selected_data, PollenExposure = as.numeric(PollenExposure))
selected_data <- transform(selected_data, Diagnosis= as.numeric(Diagnosis))

# Check the structure of the entire data frame after changes
str(selected_data)

# View the updated data
View(selected_data)

##

#"Rounding Up to the Nearest Integer for Ethnicity"_#

# Round up the 'Ethnicity' column to the nearest integer
selected_data$Ethnicity <- ceiling(selected_data$Ethnicity)

# Print the 'Ethnicity' column from the 'selected_data' data frame
print(selected_data$Ethnicity)

# View the updated data
View(selected_data)

# Check for decimal values in the 'Ethnicity' column
has_decimals <- any(selected_data$Ethnicity %% 1 != 0)
print(has_decimals)

#_#

#"Finding Mode and replacing it for NA for Ethnicity"_#
# print 'Ethnicity'column before rounding
print(selected_data$Ethnicity)

# Find the mode of the 'Ethnicity' column
mode_ethnicity <- names(sort(table(selected_data$Ethnicity), decreasing = TRUE))[1]
print(mode_ethnicity)

# Replace NA values in the 'Ethnicity' column with the calculated mode
selected_data$Ethnicity[is.na(selected_data$Ethnicity)] <- mode_ethnicity

# Print the updated data frame to verify the changes
print(selected_data$Ethnicity)

# Check if there are any NA values left in the 'ethnicity' column
remaining_na_Ethnicity <- sum(is.na(selected_data$Ethnicity))
print(remaining_na_Ethnicity)


#_#

#"Rounding Up to the Nearest Integer for Family History Asthma"_#
# print 'FamilyHistoryAsthma'column before rounding
print(selected_data$FamilyHistoryAsthma)

# Check for decimal values in the 'PhysicalActivity' column before rounding
has_decimals <- any(selected_data$FamilyHistoryAsthma %% 1 != 0)
print(has_decimals)

# Round up the 'FamilyHistoryAsthma' column to the nearest integer
selected_data$FamilyHistoryAsthma <- ceiling(selected_data$FamilyHistoryAsthma)

# Print the 'FamilyHistoryAsthma' column from the 'selected_data' data frame
print(selected_data$FamilyHistoryAsthma)

# View the updated data
View(selected_data)

# Check for decimal values in the 'FamilyHistoryAsthma' column
has_decimals <- any(selected_data$FamilyHistoryAsthma %% 1 != 0)
print(has_decimals)

#_#

#"Finding Mode and replacing it for NA for Family History Asthma"#
# Print 'FamilyHistoryAsthma' column before rounding
print(selected_data$FamilyHistoryAsthma)

# Check if there are any NA values left in the 'FamilyHistoryAsthma' column before rounding
remaining_na_FamilyHistoryAsthma <- sum(is.na(selected_data$FamilyHistoryAsthma))
print(remaining_na_FamilyHistoryAsthma)

# Find the mode of the 'FamilyHistoryAsthma' column
mode_FamilyHistoryAsthma <- names(sort(table(selected_data$FamilyHistoryAsthma), decreasing = TRUE))[1]
print(mode_FamilyHistoryAsthma)

# Replace NA values in the 'Ethnicity' column with the calculated mode
selected_data$FamilyHistoryAsthma[is.na(selected_data$FamilyHistoryAsthma)] <- mode_FamilyHistoryAsthma

# Print the updated data frame to verify the changes
print(selected_data$FamilyHistoryAsthma)

# Check if there are any NA values left in the 'ethnicity' column
remaining_na_FamilyHistoryAsthma <- sum(is.na(selected_data$FamilyHistoryAsthma))
print(remaining_na_FamilyHistoryAsthma)
##

#"Corrections 2 "#

# Check the structure of the entire data frame before changes
str(selected_data)

# Convert columns to numeric and round the 'Ethnicity' column
selected_data <- transform(selected_data, Ethnicity = as.numeric(Ethnicity))
selected_data <- transform(selected_data, PhysicalActivity = as.numeric(PhysicalActivity))
selected_data <- transform(selected_data, FamilyHistoryAsthma = as.numeric(FamilyHistoryAsthma))
selected_data <- transform(selected_data, PollenExposure = as.numeric(PollenExposure))
selected_data <- transform(selected_data, Diagnosis= as.numeric(Diagnosis))

# Check the structure of the entire data frame after changes
str(selected_data)

# View the updated data
View(selected_data)

##

#"Finding Mode and replacing it for NA for Diagnosis"#

# Print 'Diagnosis' column before rounding
print(selected_data$Diagnosis)

# Check for decimal values in the 'Ethnicity' column
has_decimals <- any(selected_data$Ethnicity %% 1 != 0)
print(has_decimals)

# Check if there are any NA values left in the 'Diagnosis' column
na_Diagnosis <- sum(is.na(selected_data$Diagnosis))
print(na_Diagnosis)

# Find the mode of the 'Diagnosis' column
mode_Diagnosis <- names(sort(table(selected_data$Diagnosis), decreasing = TRUE))[1]
print(mode_Diagnosis)

# Replace NA values in the 'Diagnosis' column with the calculated mode
selected_data$Diagnosis[is.na(selected_data$Diagnosis)] <- mode_Diagnosis

# Print the updated data frame to verify the changes
print(selected_data$Diagnosis)

# Check if there are any NA values left in the 'ethnicity' column
remaining_na_Diagnosis <- sum(is.na(selected_data$Diagnosis))
print(remaining_na_Diagnosis)

##

#"Corrections 3 "#

# Check the structure of the entire data frame before changes
str(selected_data)

# Convert columns to numeric and round the 'Ethnicity' column
selected_data <- transform(selected_data, Ethnicity = as.numeric(Ethnicity))
selected_data <- transform(selected_data, PhysicalActivity = as.numeric(PhysicalActivity))
selected_data <- transform(selected_data, FamilyHistoryAsthma = as.numeric(FamilyHistoryAsthma))
selected_data <- transform(selected_data, PollenExposure = as.numeric(PollenExposure))
selected_data <- transform(selected_data, Diagnosis= as.numeric(Diagnosis))

# Check the structure of the entire data frame after changes
str(selected_data)

# View the updated data
View(selected_data)

##


#
##

#"My Filters Started with "B"#
# E > B > A > C > D # (C') yields more data than (C)


# Count the number of rows in the data frame
num_rows <- nrow(selected_data)
print(num_rows)
#......................................................................................................................................#
# Filter 1: Diagnosis = 1
filtered_data <- selected_data[selected_data$Diagnosis == 1,]
print(filtered_data)

# View the filtered data
View(filtered_data)

# Count the number of rows when Diagnosis = 1
num_rows <- nrow(filtered_data)
print(num_rows)

#......................................................................................................................................#
# Filter 2: Pollen Exposure > 4
filtered_data_2 <- filtered_data[filtered_data$PollenExposure > 4, ]
print(filtered_data_2)

# View the filtered data
View(filtered_data_2)

# Count the number of rows when Pollen Exposure >= 4
num_rows <- nrow(filtered_data_2)
print(num_rows)

#......................................................................................................................................#
# Filter 3: Ethnicity = 0
filtered_data_3 <- filtered_data_2[filtered_data_2$Ethnicity == 0, ]
print(filtered_data_3)

# View the filtered data
View(filtered_data_3)

# Count the number of rows when Ethnicity = 0
num_rows <- nrow(filtered_data_3)
print(num_rows)

#......................................................................................................................................#
# Filter 4: Physical Activity > 6
filtered_data_4 <- filtered_data_3[filtered_data_3$PhysicalActivity > 6, ]
print(filtered_data_4)

# View the filtered data
View(filtered_data_4)

# Count the number of rows when Physical Activity <= 6
num_rows <- nrow(filtered_data_4)
print(num_rows)

#......................................................................................................................................#
# Filter 5: Family History of Asthma = 0
filtered_data_5 <- filtered_data_4[filtered_data_4$FamilyHistoryAsthma == 0, ]
print(filtered_data_5)

# View the filtered data
View(filtered_data_5)

# Count the number of rows when Family History of Asthma = 0
num_rows <- nrow(filtered_data_5)
print(num_rows)
#......................................................................................................................................#
# All Filters
# Filter 00: Ethnicity = 0, Physical Activity < 6, Pollen Exposure >4
filtered_data_00 <- filtered_data[filtered_data$Ethnicity == 0 &
                                    filtered_data$PhysicalActivity <= 6 &
                                    filtered_data$PollenExposure > 4 
                                  &filtered_data$FamilyHistoryAsthma == 0, ]
print(filtered_data_00)

# View the filtered data
View(filtered_data_00)

# Count the number of rows when Pollen Exposure >= 4
num_rows <- nrow(filtered_data_00)
print(num_rows)