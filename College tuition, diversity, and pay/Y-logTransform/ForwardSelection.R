setwd('C:/Users/blope/OneDrive/SJSU/MATH261A/Project/College tuition, diversity, and pay')
library(car)
library(leaps)
library(MASS)

par(mfrow=c(1,1))
Colleges <- read.csv("../Datasets/cleaned_df.csv", header = TRUE)
head(Colleges)

n = nrow(Colleges)
m = ncol(Colleges)

## LOG TRANSFORM Y

attach(Colleges[-5,])
# Forward variable selection
# The lowest p-value wins and highest F-value wins. 
fit.0 <- lm(I(log(early_career_pay))~1)
add1(fit.0, I(log(early_career_pay))~ make_world_better_percent + stem_percent + total_price 
     + net_cost + tuition_higher_than_national_average + type 
     + degree_length + room_and_board + 
       + Total.Minority + total_enrollment, test = "F")
# Room and board is the most important 

fit.1 <- lm(I(log(early_career_pay))~room_and_board)
add1(fit.1, I(log(early_career_pay))~ make_world_better_percent + stem_percent + total_price 
     + net_cost + tuition_higher_than_national_average + type 
     + degree_length + room_and_board + 
       + Total.Minority + total_enrollment, test = "F")
# stem percent is the second most important 

fit.2 <- lm(I(log(early_career_pay))~stem_percent+room_and_board)
add1(fit.2, I(log(early_career_pay))~ make_world_better_percent + stem_percent + total_price 
     + net_cost + tuition_higher_than_national_average + type 
     + degree_length + room_and_board + 
       + Total.Minority + total_enrollment, test = "F")
#  total_enrollement is the third most important 


fit.3 <- lm(I(log(early_career_pay))~ stem_percent+ room_and_board + total_enrollment )
add1(fit.3, I(log(early_career_pay))~ make_world_better_percent + stem_percent + total_price 
     + net_cost + tuition_higher_than_national_average + type 
     + degree_length + room_and_board + 
       + Total.Minority + total_enrollment, test = "F")
# total_price is now the next 


fit.4 <- lm(I(log(early_career_pay))~ stem_percent+room_and_board + total_price + total_enrollment)
add1(fit.4, I(log(early_career_pay))~ make_world_better_percent + stem_percent + total_price 
     + net_cost + tuition_higher_than_national_average + type 
     + degree_length + room_and_board + 
       + Total.Minority + total_enrollment, test = "F")
# type is next 


fit.5 <- lm(I(log(early_career_pay))~stem_percent+room_and_board + total_price + total_enrollment + type)
add1(fit.5, I(log(early_career_pay))~ make_world_better_percent + stem_percent + total_price 
     + net_cost + tuition_higher_than_national_average + type 
     + degree_length + room_and_board + 
       + Total.Minority + total_enrollment, test = "F")
# total minority is now next

fit.6 <- lm(I(log(early_career_pay))~stem_percent+room_and_board + total_price + total_enrollment + type + Total.Minority)
add1(fit.6, I(log(early_career_pay)) ~ make_world_better_percent + stem_percent + total_price 
     + net_cost + tuition_higher_than_national_average + type 
     + degree_length + room_and_board + 
       + Total.Minority + total_enrollment, test = "F")
# STOP! 

# Acording to forward selection: Stem is the most important variable for
#  predicting early_career_salary

# Variables are:
# stem_percent + room_and_board + total_price + total_enrollment + type + Total.Minority


vif(fit.6)
# No multicolinearity
summary(fit.6)
# great SE(Res) and solid R^2 