setwd('C:/Users/blope/Documents/GitHub/RepositoryHub/College tuition, diversity, and pay')

# Load the dataset
Colleges <- read.csv("./Datasets/cleaned_df.csv", header = TRUE)
head(Colleges)

n = nrow(Colleges)
m = ncol(Colleges)
n
m

# I want to see if linearity exists but there is an issue with the size of the 
# call below. Let's break it up into smaller pieces. 

pairs(Colleges[c(4, 5:6) ]   , pch = 19)
pairs(Colleges[c(4, 8:9) ]   , pch = 19)
pairs(Colleges[c(4, 13:15) ]   , pch = 19)
pairs(Colleges[c(4, 16:19) ]   , pch = 19)


# We might need predictor transformations for:
# total_price, in_state_tuition, in_state_total, 

# Let's see a primitive model with all predictors

fit <- lm(early_career_pay ~  make_world_better_percent + stem_percent + total_price + net_cost + tuition_higher_than_national_average + type + degree_length + room_and_board 
          + in_state_tuition + in_state_total + out_of_state_tuition +
            out_of_state_total + Total.Minority + total_enrollment, data = Colleges )
summary(fit)
# There is clearly an issue with in/out of state tuitions and totals. 

# Let's check our intuition, which variables are multicolinear 
library(car)
# vif(fit)
# This will throw an error, which is caused by two variables being perfect linear
# Combinations of one another


# Thus we must remove out_of_state_tuition

fit <- lm(early_career_pay ~  make_world_better_percent + stem_percent + total_price + net_cost + tuition_higher_than_national_average + type + degree_length + room_and_board 
          + in_state_tuition + in_state_total + out_of_state_total 
          + Total.Minority + total_enrollment, data = Colleges )
summary(fit)
vif(fit) # Recall that a VIF Value >10 indicates multicolinearity. 

# There are multicollinearites with: in_state_tution, in_state_total,
# out_of_state_tuition, and total_price

# Therefore we need to consider a model that does not include all of the 
# in/out-state variables above or we can remove them from contention. 

# Total price is the sum of the granular in/out-of-state tuition + r&b
# Let's remove granular variables from contention and get a high-level review


fit <- lm(early_career_pay ~  make_world_better_percent + stem_percent + total_price 
          + net_cost + tuition_higher_than_national_average + type 
          + degree_length + room_and_board + 
          + Total.Minority + total_enrollment, data = Colleges )
summary(fit)
vif(fit)
# Now there is NOT high multi-colinearity amound our variables. 


# With multicolinearity out of the way let's fix the predictors. 
pairs(early_career_pay ~  make_world_better_percent + stem_percent + total_price 
      + net_cost + room_and_board + 
      + Total.Minority + total_enrollment, data = Colleges )
# Linearity is present among the remaining predictors. 


# For the remaining predictors: I could consider a predictor x-form but they all 
# appear to have a linear relationship. 
par(mfrow=c(2,2))
plot(fit)
# Our data looks normal. Let's see if response x-form is necessary w/ boxcox

library(MASS)

par(mfrow = c(1,1))
boxcox(fit)
# Recall that a zero in box cox is a log transformation on the Y 
fit.log <- lm( I(log(early_career_pay)) ~   make_world_better_percent
               + stem_percent + total_price 
               + net_cost + tuition_higher_than_national_average + type 
               + degree_length + room_and_board + 
                 + Total.Minority + total_enrollment, data = Colleges )
summary(fit.log) # Residual SE looks amazing
summary(fit) # High SE
# Let's see how model selection is different when y is log. 


pairs( I(log(early_career_pay)) ~  make_world_better_percent + stem_percent + total_price 
      + net_cost + room_and_board + 
        + Total.Minority + total_enrollment, data = Colleges )
# Linearity looks good.

par(mfrow=c(2,2))  
plot(fit.log)
# Residual assumptions looks great! 

# Log x-formed y looks great! 