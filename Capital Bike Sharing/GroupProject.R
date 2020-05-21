library(readr)
library(alr4)
library(dplyr)
day <- read_csv("~/126 Regression/Bike-Sharing-Dataset/day.csv")


test0 <- lm( cnt ~ . - cnt,   data = day )
summary(test0)


day <- select(day,  c(- casual, - registered, - instant, - dteday, -yr) ) 
y <- day$cnt
test0 <- lm( y ~ . - cnt ,   data = day )
summary(test0)

vif(test0)

day <- select(day,  c(- atemp, - cnt ))
test0 <- lm( y ~ . , data = day )
vif(test0)

avPlots(test0)

scatterplotMatrix(~ y + temp + windspeed + hum + factor(season) + factor(mnth) + factor(holiday)
                  + factor(weekday) + factor(workingday) + factor(weathersit) , data =day)


test1 <- test0
summary(test1)
par(mfrow = c( 1, 3))
for( i in 1:3){
  plot( test1 , which = i)}
par(mfrow = c( 1, 1))


min(day$temp)
min(day$windspeed)
min(day$hum)


day$hum1 <- with(day, (hum + .001 )) 
diag1  <-  powerTransform(cbind(hum1, windspeed , temp) ~ 1, day)
summary(diag1)


testTransform(diag1, lambda = c(1, .5, 1))


day_trsf <- with(day, data.frame( hum1 , sqrt(windspeed), temp ))
pairs(day_trsf)

windspeed.sqrt <- sqrt(day$windspeed)
day <- cbind( day,  windspeed.sqrt )
day <- select(day , -c(hum, windspeed) )


test2 <- lm(y ~. , data = day)
summary(test2)

par(mfrow = c( 1, 3))
for( i in 1:3){
  plot( test2 , which = i)
  
} 
par(mfrow = c( 1, 1))


bc <- boxCox(test2) 
lambda.opt <- bc$x[which.max(bc$y)] 
lambda.opt 


y <- sqrt(y)
test2 <- lm(y ~ . , data = day) 

par(mfrow = c( 1, 3))
for( i in 1:3){
  plot( test2 , which = i)
  
} 
par(mfrow = c( 1, 1))


for( i in 1:3){
  plot( test2 , which = i)
  
} 


#Inital model
m0 = lm(y ~ temp , day)

#Full model
f = ~ season  + mnth + holiday + weekday + workingday + weathersit + temp + hum1 + windspeed.sqrt
#AIC method
m.forward = step(m0 , f ,direction = 'forward' )


n=731
step(m0, f, direction = 'forward', k = log(n), trace = 0) 


BIC <- lm(formula = y ~ temp + weathersit + season + windspeed.sqrt + hum1, data = day)
AIC <- lm(y ~ temp + weathersit + season + windspeed.sqrt + hum1 + holiday + weekday + workingday , data = day)
anova(BIC, AIC)


BIC.factor <- lm(formula = y ~ temp + factor(weathersit) + factor(season) + windspeed.sqrt + hum1 , data = day)
summary(BIC.factor)


for( i in 1:3){
  plot( BIC.factor , which = i)
  
} 

diag2  <-  powerTransform(cbind(hum1, windspeed.sqrt , temp ) ~ 1, day)
summary(diag2)
#When dummy variables are include we need to transform a bit
#Basis

#We must consider a non-parallel model. 

test3 <- lm(y ~ temp*factor(weathersit)*factor(season) + windspeed.sqrt*hum1, data = day  )
summary(test3)

for( i in 1:3){
  plot( test3 , which = i)
} 
#although 


test4 <- lm(y ~ temp* factor(weathersit)*factor(season) + hum1 + windspeed.sqrt, data = day  )
summary(test4)

plot(test4, which =1)

test5 <- lm(y ~ temp: factor(weathersit):factor(season) + hum1 + windspeed.sqrt, data = day  )
summary(test5)
plot(test5, which =1)
#ugly af

test6 <- lm(y ~ temp: factor(weathersit)*factor(season) + hum1 + windspeed.sqrt, data = day  )
summary(test6)
for( i in 1:3){
  plot( test6 , which = i)
} 

test7 <-  lm(y ~ temp* factor(weathersit):factor(season) + hum1 + windspeed.sqrt, data = day  )
summary(test7)

anova(test7, test4)
