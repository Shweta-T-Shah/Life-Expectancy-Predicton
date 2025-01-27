#Link of the dataset(url) :  https://www.kaggle.com/kumarajarshi/life-expectancy-who

library(tidyverse)
library(plotly)

#Reading csv file
life_expectancy_data <- read.csv("C:/Users/shah3sw/OneDrive - University of Cincinnati/Data_Analysis_Method_Project/Life Expectancy Data.csv")
head(life_expectancy_data)

#Dimensions : Gives numbers of rows and columns
dim(life_expectancy_data)

# Structure of dataset
str(life_expectancy_data)

#Summary
summary(life_expectancy_data)

#Check for missing values
colSums(is.na(life_expectancy_data))


#Missing value counts
# BMI - 34   11%
# Hep B 553 18%   
#Alcohol - 194    6%
# Total Expenditure - 226   7.6%
#Diptheria - 19
#GDP - 448   15%
#Population - 652   22.19%
#Income composition of resources - 167  5.6%
#Schooling - 163   5.5%
#thin 1-19 -34
# thin 5-9 - 34


# Select numeric variables for calculating mean
life_expectancy_data_num <- select(life_expectancy_data,-c(1,2,3))

#Calculate means of all the numeric variables
colMeans(life_expectancy_data_num, na.rm = TRUE)


# Impute missing values in numeric variables with mean
for(i in 4:ncol(life_expectancy_data)) {
  life_expectancy_data[ , i][is.na(life_expectancy_data[ , i])] <- mean(life_expectancy_data[ , i], na.rm=TRUE)
}
summary(life_expectancy_data) 


# We can see that now the data set has no missing values
colSums(is.na(life_expectancy_data))


#Plotting box plots of life expectancy to understand outliers
boxplot(life_expectancy_data$Life.expectancy, xlab="Life Expectancy")

#Performing a linear regression and finding out factors affecting life expectancy 

#Life Expectancy vs Percentage Expenditure

cor(life_expectancy_data$Life.expectancy, life_expectancy_data$percentage.expenditure)

library(ggplot2)
library(GGally)
ggpairs(life_expectancy_data %>% select(Life.expectancy, percentage.expenditure))

model_per_expenditure <- lm(percentage.expenditure ~ Life.expectancy, life_expectancy_data)
summary(model_per_expenditure)

model_per_expenditure$coefficients[2]



library(plotly)
life_expectancy_vs_percenntage_expenditure <- plot_ly(data = life_expectancy_data, x = ~percentage.expenditure, y = ~Life.expectancy,
                                      marker = list(size = 10,
                                                    color = 'rgba(0,255,0, .9)',
                                                    line = list(color = 'rgba(255, 0, 38, 0.2)',
                                                                width = 2)))

life_expectancy_vs_percenntage_expenditure <- life_expectancy_vs_percenntage_expenditure %>% layout(title = 'Scatter Plot: Life Expectancy vs Percentage Expenditure',
                                                                    yaxis = list(zeroline = FALSE),
                                                                    xaxis = list(zeroline = FALSE))

life_expectancy_vs_percenntage_expenditure



install.packages("datarium")
library(tidyverse)
data("life_expectancy_data", package = "datarium")
head(life_expectancy_data, 4)



library(tidyverse)


model <- lm(life_expectancy_data_num ~ ., data = life_expectancy_data)
summary(model)