setwd('C:/Users/blope/Documents/GitHub/RepositoryHub/College tuition, diversity, and pay')
library(car)
library(leaps)
library(MASS)


Colleges <- read.csv("./Datasets/cleaned_df.csv", header = TRUE)
head(Colleges)

n = nrow(Colleges)
m = ncol(Colleges)

# Without high multicolinearity. 
fit <- lm(I(log(early_career_pay)) ~  make_world_better_percent + stem_percent + total_price 
          + net_cost + tuition_higher_than_national_average + type 
          + degree_length + room_and_board + 
            + Total.Minority + total_enrollment, data = Colleges )
summary(fit)
par(mfrow = c(1,2)) # Reducing the number of plots on page 
# Gives vooks bar plots. 
plot(fit, which = c(1,2))
plot(fit, which = c(3,4)) # Cooks bar plot here  
par(mfrow = c(1,1))
cooks_d_barplot_thresh = 4/n # A threshold sometimes used for cooks bar plots. 
cooks_d_barplot_thresh
# Cook's distance is not larger than 1 for any observations. So by 
# Strict thersholds there are no outliers. But for 4/n ther are outliers. 

plot(fit, which = c(4)) # Only cooks bar plot. 
# Let's explore outlier according to 4/n

# Let's remove instance 5
fit <- lm(I(log(early_career_pay)) ~  make_world_better_percent + stem_percent + total_price 
          + net_cost + tuition_higher_than_national_average + type 
          + degree_length + room_and_board + 
          + Total.Minority + total_enrollment, data = Colleges[-5,] )
summary(fit)
# R-Squared increased by 2%!!!!!

par(mfrow = c(1,2))
plot(fit, which = c(1,2))
plot(fit, which = c(3,4))
par(mfrow = c(1,1))




### Removing Instances 5, 33, 35, 438

fit <- lm(I(log(early_career_pay)) ~  make_world_better_percent + stem_percent + total_price 
          + net_cost + tuition_higher_than_national_average + type 
          + degree_length + room_and_board + 
            + Total.Minority + total_enrollment, data = Colleges[-c(5, 33, 35, 438),] )
summary(fit)
par(mfrow = c(1,2))
plot(fit, which = c(1,2))
plot(fit, which = c(3,4))
par(mfrow = c(1,1))
# The outliers stay the same. 

fit <- lm(I(log(early_career_pay)) ~  make_world_better_percent + stem_percent + total_price 
          + net_cost + tuition_higher_than_national_average + type 
          + degree_length + room_and_board + 
            + Total.Minority + total_enrollment, data = Colleges[-c(5, 33, 35, 438, 315, 231), ] )
summary(fit)
par(mfrow = c(1,2))
plot(fit, which = c(1,2))
plot(fit, which = c(3,4))
par(mfrow = c(1,1))


# Let's explore characteristcs of outliers. 
Colleges[c(5, 33, 35, 438, 315, 231), ]
# Despite this the tail observations: 315 and 231 are both health science Unis

# Using google on college name, 264 and 217 are also health colleges. 
# Stem percent is zero at these colleges, That could be the issue. 

 
# If given time and resources we could find which colleges are strictly health 
# colleges. This could reduce issues with the schools by modeling for it. 

  
