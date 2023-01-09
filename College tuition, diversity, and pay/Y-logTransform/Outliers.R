setwd('C:/Users/blope/OneDrive/SJSU/MATH261A/Project/College tuition, diversity, and pay')
library(car)
library(leaps)
library(MASS)


Colleges <- read.csv("./Datasets/cleaned_df.csv", header = TRUE)
head(Colleges)

n = nrow(Colleges)
m = ncol(Colleges)

# Variables without high multicolinearity. 
fit <- lm(I(log(early_career_pay)) ~  make_world_better_percent + stem_percent + total_price 
          + net_cost + tuition_higher_than_national_average + type 
          + degree_length + room_and_board + 
            + Total.Minority + total_enrollment, data = Colleges )
summary(fit)
par(mfrow = c(1,2))
plot(fit, which = c(1,2))
plot(fit, which = c(3,4))
par(mfrow = c(1,1))
cooks_d_barplot_thresh = 4/n
cooks_d_barplot_thresh
# Cook's distance is not larger than 1 for any observations. Thus no outliers 
# according to this test. 
# Scale location is somewhat concerning 

plot(fit, which = c(4))


### Let's remove instance 5

# Variables without high multicolinearity. 
fit <- lm(I(log(early_career_pay)) ~  make_world_better_percent + stem_percent + total_price 
          + net_cost + tuition_higher_than_national_average + type 
          + degree_length + room_and_board + 
          + Total.Minority + total_enrollment, data = Colleges[-5,] )
summary(fit)
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
# Despite this the tail observations: 315 and 231 are both nursing colleges.

fit <- lm(I(log(early_career_pay)) ~  make_world_better_percent + stem_percent + total_price 
          + net_cost + tuition_higher_than_national_average + type 
          + degree_length + room_and_board + 
            + Total.Minority + total_enrollment, data = Colleges[-c(5, 33, 35, 438, 315, 231), ] )
summary(fit)
par(mfrow = c(1,2))
plot(fit, which = c(1,2))
plot(fit, which = c(3,4))
par(mfrow = c(1,1))
# An interesting observation! 
# An intern should be tasked with determining which colleges are nursing/pharm/medical colleges. 
# An indicator variable should significantly change the R^2 once we have this. 
# LOl, 264 and 217 are colleges catering to health careers



### From here everything is garbage. 

  # IDK IF THE two measure have an easy way of attaining the outliers. 
  # DFBETAS
  thresh <-  2/sqrt(n)
  thresh 
  
  par(mfrow=c(1,1))
  library(ggplot2)
  
  
  dfbetas_college <- as.data.frame(dfbetas(fit))
  col_names <- colnames(dfbetas_college)
  col_names <- col_names[-1]
  par(mfrow= c(4,3))
  for (i in col_names){
    plot(dfbetas_college[[i]], ylab = i)
    abline(h = thresh, lty = 2)
    abline(h = -thresh, lty = 2)
  }
  
  #plot DFBETAS for disp with threshold lines
  
  plot(dfbetas_college, type='h')
  abline(h = thresh, lty = 2)
  abline(h = -thresh, lty = 2)
    
    
  plot(dfbetas_college$stem_percent , type='h')
  abline(h = thresh, lty = 2)
  abline(h = -thresh, lty = 2)
  
  # DFFITS
  
  max(dffits(fit)) >2*sqrt( 11 / n) 

  
# Predictions of outliers
  
# Model from backward selection 
exp(predict(fit.5, data.frame( Colleges[c(5, 33, 35, 438, 315, 231), ])))
  
