setwd('C:/Users/blope/OneDrive/SJSU/MATH261A/Project/College tuition, diversity, and pay')
library(leaps)

par(mfrow=c(1,1))
Colleges <- read.csv("./Datasets/cleaned_df.csv", header = TRUE)
head(Colleges)

n = nrow(Colleges)
m = ncol(Colleges)


attach(Colleges[-5, ])

# Drop highest p-value and lowest F-value
# For this let alpha = .05
fit.9 <- lm( I(log(early_career_pay)) ~ make_world_better_percent + stem_percent + total_price 
            + net_cost + tuition_higher_than_national_average + type 
            + degree_length + room_and_board
            + Total.Minority + total_enrollment)
drop1( fit.9, I(log(early_career_pay))~ make_world_better_percent + stem_percent + total_price 
     + net_cost + tuition_higher_than_national_average + type 
     + degree_length + room_and_board + 
       + Total.Minority + total_enrollment, test = "F")
# Least important variable is make_world_better_percent

fit.8 <- lm( I(log(early_career_pay)) ~ stem_percent + total_price 
             + net_cost + tuition_higher_than_national_average + type 
             + degree_length + room_and_board
             + Total.Minority + total_enrollment)
drop1( fit.8, I(log(early_career_pay))~ stem_percent + total_price 
       + net_cost + tuition_higher_than_national_average + type 
       + degree_length + room_and_board + 
         + Total.Minority + total_enrollment, test = "F")
# second is  degree_length


fit.7 <- lm( I(log(early_career_pay)) ~ stem_percent + total_price 
             + net_cost + tuition_higher_than_national_average + type 
             + room_and_board
             + Total.Minority + total_enrollment)
drop1( fit.7, I(log(early_career_pay))~ stem_percent + total_price 
       + net_cost + tuition_higher_than_national_average + type 
       + room_and_board + 
         + Total.Minority + total_enrollment, test = "F")
# third is net cost 

fit.6 <- lm( I(log(early_career_pay)) ~ stem_percent + total_price 
             + tuition_higher_than_national_average + type 
             + room_and_board
             + Total.Minority + total_enrollment)
drop1( fit.6, I(log(early_career_pay))~ stem_percent + total_price 
       + tuition_higher_than_national_average + type 
       + room_and_board + 
         + Total.Minority + total_enrollment, test = "F")
# fourth is tution higher than national average 

fit.5 <- lm( I(log(early_career_pay)) ~ stem_percent + total_price 
            + type 
             + room_and_board
             + Total.Minority + total_enrollment)
drop1( fit.5, I(log(early_career_pay))~ stem_percent + total_price 
       + type 
       + room_and_board 
       + Total.Minority + total_enrollment, test = "F")
#STOP!! 

summary(fit.5)
plot(fit.5)
# 6 Variables are:  stem_percent + total_price + type + room_and_board + Total.Minority + total_enrollment
# This agrees with forward selection.


# Make a prediction 
san_jose <- data.frame(stem_percent = 28.0	, total_price = 27655.5 , type = 1,
           room_and_board = 16442.0	, Total.Minority = 20662.0	,
           total_enrollment= 32713.0)
log.y <- predict(fit.5, newdata = san_jose) # log(y)

exp(log.y) # Actual prediction 
# Real early_career_salary is 63000.0	

exp(-4.805e-06)

exp(fit.5$coefficients[2]) # A 0.4% increase in early salary with a marginal increase in stem percent 

(exp(fit.5$coefficients[6]) - 1) *100


plot(fit.5)
