setwd('C:/Users/blope/Documents/GitHub/RepositoryHub/College tuition, diversity, and pay')
library(car)
library(leaps)
library(MASS)

par(mfrow=c(1,1))
Colleges <- read.csv("./Datasets/cleaned_df.csv", header = TRUE)
head(Colleges)

n = nrow(Colleges)
m = ncol(Colleges)

attach(Colleges[-5])


# Forward/back selection had us arrive at 
fit <- lm(early_career_pay~stem_percent+room_and_board + total_price 
            + total_enrollment + tuition_higher_than_national_average
            + type)
summary(fit)

# however I think this is too many variables. I prefer 4 but that r-squared is 
# too low. Let's see how regression trees fit on the forward variables.



# How to compare to the r-squared for linear vs tree? Use psuedo r-squared
# rsq (regression only) “pseudo R-squared”: 1 - mse / Var(y)
# I guess Residual mean deviance == mse in this case
calc_pseudo_rSquared <- function(y_arg, x_variables){
  y = y_arg
  y_predicted = predict(tree,x=x_variables)
  RMSE = sqrt(mean((y_predicted-y)^2))
  RMSE0 = sd(y-mean(y));
  r_sq = 1 - (RMSE/RMSE0)
  r_sq
}


library(tree)
# Only 7 
tree <- tree(early_career_pay~stem_percent+room_and_board + total_price 
             + total_enrollment + tuition_higher_than_national_average
             + type)
plot(tree)
text(tree)

tree
summary(tree)
# Residual mean variance is similar in magnitude to 
# a simple lienar model. 


# Only 4: Stem,  total_price, total_enrollment
# This had lm r-squared of .66 msres of 23k
tree <- tree(early_career_pay~stem_percent + total_price 
             + total_enrollment)
plot(tree)
text(tree)

tree
summary(tree)
calc_pseudo_rSquared(early_career_pay, cbind(stem_percent, total_price, total_enrollment))
# This mean variance is similar to the last. 
# Let's reduce the number of terminal nodes.


tree <- tree(early_career_pay~stem_percent + total_price 
             + total_enrollment, control=tree.control(700, mincut = 100))
plot(tree)
text(tree)

tree
summary(tree)

# This model is terrible because we only use 4 leaf nodes to describe salary
calc_pseudo_rSquared(early_career_pay, cbind(stem_percent, total_price, total_enrollment))


# Yeah, I think the linear models will be winners. 