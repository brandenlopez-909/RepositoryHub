setwd('C:/Users/blope/OneDrive/SJSU/MATH261A/Project/College tuition, diversity, and pay')
library(leaps)


par(mfrow=c(1,1))
Colleges <- read.csv("./Datasets/cleaned_df.csv", header = TRUE)
head(Colleges)

n = nrow(Colleges)
m = ncol(Colleges)

attach(Colleges[-5, ])


fit.forw.auto <- regsubsets(x=cbind(make_world_better_percent, stem_percent, total_price, 
            net_cost, tuition_higher_than_national_average, type, 
            degree_length, room_and_board, Total.Minority, total_enrollment),
            y=I(log(early_career_pay)),  method = "forward")
summary(fit.forw.auto)


fit.back.auto <- regsubsets(x=cbind(make_world_better_percent, stem_percent, total_price, 
                                    net_cost, tuition_higher_than_national_average, type, 
                                    degree_length, room_and_board, Total.Minority, total_enrollment),
                            y=I(log(early_career_pay)),  method = "backward")


# Stepwise
fit.stepwise.auto <- regsubsets(x=cbind(make_world_better_percent, stem_percent, total_price, 
                                    net_cost, tuition_higher_than_national_average, type, 
                                    degree_length, room_and_board, Total.Minority, total_enrollment),
                            y=I(log(early_career_pay)),  method = "seqrep")
summary(fit.stepwise.auto )


attach(Solar)
x5.xform <- I((x5 - 13.145)^2)
forward.x5.xform <- regsubsets(x=cbind(x1,x2,x3,x4, x5.xform), y=y,  method = "forward")
summary(forward.x5.xform)


# stem is definently our most important variable 

# I guess 70% is the best possible R-squared without interaction terms. 