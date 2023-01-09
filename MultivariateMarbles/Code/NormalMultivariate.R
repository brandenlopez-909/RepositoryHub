setwd("C:/Users/blope/OneDrive/SJSU/MATH257/Project")
marbles <- read.table(file = "Marbles.txt", 
                      sep = "\t", header=TRUE)
str(marbles)
marbles$group <- as.factor(marbles$group)

head(marbles)
View(marbles)

DV <- cbind(marbles$d18O, marbles$d13C, marbles$dolomite, 
            marbles$epr_intens, marbles$epr_linwid, marbles$colour, 
            marbles$mgs)

output <- lm(DV ~ group, data = marbles)
manova_out <- manova(output)
summary(manova_out)

res <- data.frame(residuals(manova_out))
dim(res)
names(res) <- c("d18O_r", "d13C_r", "dolomite_r", "epr_intens_r", 
                "epr_linwid_r", "colour_r", "mgs_r")
head(res)
library(car)
scatterplotMatrix(res[1:7],smooth=F)

# par(mfrow=c(7,2))
hist(res[,1],main = "Histogram of d18O",xlab = "Res1")
box()
qqnorm(res[,1])
qqline(res[,1])
hist(res[,2],main = "Histogram of d13C",xlab = "Res2")
box()
qqnorm(res[,2])
qqline(res[,2])
hist(res[,3],main = "Histogram of dolomite",xlab = "Res3")
box()
qqnorm(res[,3])
qqline(res[,3])
hist(res[,4],main = "Histogram of epr_intens",xlab = "Res4")
box()
qqnorm(res[,4])
qqline(res[,4])
hist(res[,5],main = "Histogram of epr_linwid",xlab = "Res5")
box()
qqnorm(res[,5])
qqline(res[,5])
hist(res[,6],main = "Histogram of colour",xlab = "Res6")
box()
qqnorm(res[,6])
qqline(res[,6])
hist(res[,7],main = "Histogram of mgs",xlab = "Res7")
box()
qqnorm(res[,7])
qqline(res[,7])

# par(mfrow=c(1,1))

library(MVN)
mvn(res[,1:7],multivariatePlot="qq",multivariateOutlierMethod="quan")
# The data are not MVN

library(heplots)
tbox<-boxM( DV ~ group, data = marbles)
summary(tbox)





### Try colors in online shopping data:
shop <- read.csv("color_onlineshopping.csv")
str(shop)

# Convert to factors
shop$trt_id <- as.factor(shop$trt_id)
shop$hue <- as.factor(shop$hue)
shop$bright <- as.factor(shop$bright)
shop$price <- as.factor(shop$price)
shop$X_hue <- as.factor(shop$X_hue)
shop$X_bright <- as.factor(shop$X_bright)
shop$X_price <- as.factor(shop$X_price)
head(shop)

DV <- cbind(shop$quality, shop$trt_id)

output1 <- lm(DV ~ hue*bright, data = shop)
manova_out1 <- manova(output1)
summary(manova_out1)

output2 <- lm(DV ~ hue*price, data = shop)
manova_out2 <- manova(output2)
summary(manova_out2)

output3 <- lm(DV ~ bright*price, data = shop)
manova_out3 <- manova(output3)
summary(manova_out3)


res1 <- data.frame(residuals(manova_out1))
res2 <- data.frame(residuals(manova_out2))
res3 <- data.frame(residuals(manova_out3))

head(res1)
head(res2)
head(res3)

library(car)
scatterplotMatrix(res1[1:2],smooth=F)
scatterplotMatrix(res2[1:2],smooth=F)
scatterplotMatrix(res3[1:2],smooth=F)

# par(mfrow=c(7,2))
hist(res1[,1],main = "Histogram of Quality",xlab = "Res1")
box()
qqnorm(res1[,1])
qqline(res1[,1])
hist(res2[,1],main = "Histogram of Quality",xlab = "Res2")
box()
qqnorm(res2[,1])
qqline(res2[,1])
hist(res3[,1],main = "Histogram of Quality",xlab = "Res3")
box()
qqnorm(res3[,1])
qqline(res3[,1])

hist(res1[,2],main = "Histogram of Trt_id",xlab = "Res1")
box()
qqnorm(res1[,2])
qqline(res1[,2])
hist(res2[,2],main = "Histogram of Trt_id",xlab = "Res2")
box()
qqnorm(res2[,2])
qqline(res2[,2])
hist(res3[,2],main = "Histogram of Trt_id",xlab = "Res3")
box()
qqnorm(res3[,2])
qqline(res3[,2])
