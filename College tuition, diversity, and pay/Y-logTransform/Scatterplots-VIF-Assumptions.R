setwd('C:/Users/junglebook/OneDrive/SJSU/MATH261A/Project/College tuition, diversity, and pay')

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

# Let's see a primative model with all predictors

fit <- lm(early_career_pay ~  make_world_better_percent + stem_percent + total_price + net_cost + tuition_higher_than_national_average + type + degree_length + room_and_board 
          + in_state_tuition + in_state_total + out_of_state_tuition +
            out_of_state_total + Total.Minority + total_enrollment, data = Colleges )
summary(fit)

# Let's check our intuition, which variables are multicolinear 
library(car)
# This will throw an error, which is caused by two variables being perfectly 
# correlated. Thus we must remove out_of_state_tuition
# vif(fit)


fit <- lm(early_career_pay ~  make_world_better_percent + stem_percent + total_price + net_cost + tuition_higher_than_national_average + type + degree_length + room_and_board 
          + in_state_tuition + in_state_total + out_of_state_total 
          + Total.Minority + total_enrollment, data = Colleges )
summary(fit)
vif(fit)
# Now we see there are multicorrelation with: in_state_tution, in_state_total,
# out_of_state_tuition, and total_price
# Because of this we need to consider a model that does not include all of the 
# state variables above or we can remove them from contention. 

# Because _total includes the tuition, let's look at the total cost for ease. 


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


# The remaining variables, I could consider a predictor transformation but many 
# appear to have a linear relationship. 

par(mfrow=c(2,2))
plot(fit)
# WOW our data is clean af, our plots indicate constant variance and 
# normality. 

# The predictors we should transform are: total_price, in_state_total, out_of_state_total,

library(MASS)

par(mfrow = c(1,1))
boxcox(fit)
# REcall that a zero in box cox is a log transformation on the Y 
fit.log <- lm( I(log(early_career_pay)) ~   make_world_better_percent + stem_percent + total_price 
               + net_cost + tuition_higher_than_national_average + type 
               + degree_length + room_and_board + 
                 + Total.Minority + total_enrollment, data = Colleges )
summary(fit.log)
# So despite going with a log tranformation, the r-squared for log is worse.  
summary(fit)
# Let's see how model selection is different when y is log. 

vif(fit.log)

