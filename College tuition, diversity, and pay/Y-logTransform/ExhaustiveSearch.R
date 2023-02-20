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
  # R-squared is not high despite having a tremendous amount of variables. 
  # I assume that we will not have a high r-squared in general. 
  
  
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
  # Mallow's cp is not great but is not the only thing to cnosider. 
  
  # For 4 or more predictors, our summary statistics cluster around the same 
  # values. Making manual selection difficult. 
  
  # Hopefully our automatic selection methods work well. 
