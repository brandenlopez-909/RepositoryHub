setwd('C:/Users/blope/OneDrive/SJSU/MATH261A/Project/College tuition, diversity, and pay')
library(leaps)

par(mfrow=c(1,1))
Colleges <- read.csv("./Datasets/cleaned_df.csv", header = TRUE)
head(Colleges)

n = nrow(Colleges)
m = ncol(Colleges)

# First Let's look at a summary of the overfitted model without 
# multicolinearity 

  # Variables without high multicolinearity. 
  fit <- lm(I(log(early_career_pay)) ~  make_world_better_percent + stem_percent + total_price 
            + net_cost + tuition_higher_than_national_average + type 
            + degree_length + room_and_board + 
              + Total.Minority + total_enrollment, data = Colleges[-5,] )
  summary(fit)
  # Notice how R-squares is not high despite having a tremendous amount of variables. 
  # I assume that we will not have a high r-squared in general. 
  
  vif(fit) # Nothing higher than 10 => No multicolinearity. 
  
  # Plot for linear predictors. 
  pairs(I(log(early_career_pay)) ~  make_world_better_percent + stem_percent + total_price 
        + net_cost + room_and_board + 
          + Total.Minority + total_enrollment, data = Colleges )
  # Ask Dr.Bremer if we should transform predictors here? 
  # I am unsure if we should, linearity is present among most. 
  par(mfrow=c(2,2))
  plot(fit) # Plots are immaculate. 
  par(mfrow=c(1,1))
  # Check response. 
  boxcox(fit) # We don't need to log x-form response. 
  
  
#  
# Now I perform variable selection. Let's start with an exhaustive search. 
#  
  # 1c from hw10
  attach(Colleges[-5,])
  exhaustive <- regsubsets(x=cbind( make_world_better_percent, stem_percent,
                                    total_price, net_cost, 
                                    tuition_higher_than_national_average, type, 
                                    degree_length, room_and_board, 
                                    Total.Minority, total_enrollment),
                           y= I(log(early_career_pay)),
                           method = "exhaustive", all.best = FALSE, nbest = 3)
  
  Cp <- summary(exhaustive)$cp
  AdjR2 <- summary(exhaustive)$adjr2
  SSRes <- summary(exhaustive)$rss
  R2 <- summary(exhaustive)$rsq
  Matrix <- summary(exhaustive)$which
  
  # Trickery from the professor's code.
  p <- apply(Matrix,1, sum)
  MSRes <- SSRes/(n-p)
  
  
  output <- cbind(p, Matrix, MSRes, R2, AdjR2, Cp)
  colnames(output)[3:12] <- c("x1", "x2", "x3", "x4", "x5", 
                             "x6", "x7", "x8", "x9", "x10") 
  output
  # The cp is not the best but I can live with it. Techniically there is a model where 
  # CP is met, a model with 9 variables (including slope in the count.)
