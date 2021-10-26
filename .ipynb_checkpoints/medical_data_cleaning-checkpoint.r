setwd("D:/schools/wgu_masters/d206-data_cleaning/medical_data")
#install.packages(c("ggplot2", "dplyr", "tibble"))
library(dplyr)
library(tibble)
library(ggplot2)
rawData <- read.csv('medical_raw_data.csv');
str(rawData);
#remove redundant columns, and columns that will not contribute meaningfully to analysis
#column x is removed because it is functionally identical to CaseOrder, Lat and Lng are
#dropped due to being personally identifiable information about patient that does not contribute
#more meaningfully to analysis than anonomized columns such as Area and Timezone already do.
#other columns are dropped due to being internal system labels that are not useful for analysis.
df <- subset(rawData, select = -c(X, Customer_id, Interaction, UID, Lat, Lng))

#remove column CaseOrder and set as index
df <- df %>% column_to_rownames('CaseOrder')

#remove duplicated rows
df <- df[!duplicated(df), ]

#determine columns that contain missing values
colSums(is.na(df));

#
#convert values that should be yes/no to categorical data
summary(df)
unique(df$Overweight)
unique(df$Anxiety)
unique(df$ReAdmis)
unique(df$Soft_drink)
unique(df$HighBlood)
unique(df$Stroke)
unique(df$Arthritis)
unique(df$Diabetes)
unique(df$Hyperlipidemia)
unique(df$BackPain)
unique(df$Allergic_rhinitis)
unique(df$Reflux_esophagitis)
unique(df$Asthma)
df$Overweight <- as.logical(df$Overweight)
df$Overweight <- ifelse(df$Overweight, "Yes", "No")
df$Overweight
df$Anxiety <- as.logical(df$Anxiety)
df$Anxiety <- ifelse(df$Anxiety, "Yes", "No")
df$Anxiety
numeric_data <- df[, c("Population", "Children", "Age", "Income", "VitD_levels", "Doc_visits", 
                   "Full_meals_eaten", "VitD_supp", "Initial_days",  "TotalCharge", 
                   "Additional_charges")]
head(numeric_data)
boxplot(aes(numeric_data))


