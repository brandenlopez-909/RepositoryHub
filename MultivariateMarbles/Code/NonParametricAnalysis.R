setwd("./Project")

# I was having issues with Louis' read, I made my own
marbles <- read.table(file = "Marbles.txt", 
                      sep = "\t", header=TRUE)

# marbles <- read.csv("Project Data Set 1 - Marbles.csv")
str(marbles)
marbles$group <- as.factor(marbles$group)

head(marbles)
# View(marbles)

DV <- cbind(marbles$d18O, marbles$d13C, marbles$dolomite, 
            marbles$epr_intens, marbles$epr_linwid, marbles$colour, 
            marbles$mgs)

# MV. Variables as a fucntion of group
output <- lm(DV ~ group, data = marbles)
# While I would use the linear model for Manova

# To perform Kruscal-Wallis I need to rank the data or order it ascending order
# Which metrics am I using for this? 
head(marbles)

# One issue with Krisical wallis is that the function works on one 
# predictor variables at a time, 
DV <- cbind(marbles$d18O, marbles$d13C, marbles$dolomite, 
            marbles$epr_intens, marbles$epr_linwid, marbles$colour, 
            marbles$mgs)


marbles$group <- ordered(marbles$group,
                      levels = c(1:6))


# Kriical wallis uses it's own function 
kruskal.test(marbles$d18O ~ marbles$group)
kruskal.test(marbles$d13C ~ marbles$group)
kruskal.test(marbles$dolomite ~ marbles$group)
kruskal.test(marbles$epr_intens ~ marbles$group)
kruskal.test(marbles$epr_linwid ~ marbles$group)
kruskal.test(marbles$colour ~ marbles$group)
kruskal.test(marbles$mgs ~ marbles$group)
# Wow not a single one passed. I guess this enforces significant differences 
# in queries 

library(dplyr)
group_by(marbles, group) %>%
  summarise(
    count = n(),
    mean = mean(d18O, na.rm = TRUE),
    sd = sd(d18O, na.rm = TRUE),
    median = median(d18O, na.rm = TRUE),
    IQR = IQR(d18O, na.rm = TRUE)
  )
# There appears to two be two different group means for d180. 4 and 6.5

# Wow it didn't save my code.

pairwise.wilcox.test(marbles$d18O, marbles$group,
                     p.adjust.method = "BH")
# Pairwise testing indicates that (3,4,5,6) are the same. Like the summary
# However we fail to rejct that (1,2) are similar


pairwise.wilcox.test(marbles$d13C,  marbles$group)
# (2, 3), (3, c[5,6]), (4, c[5,6]) are same


pairwise.wilcox.test(marbles$dolomite, marbles$group)


pairwise.wilcox.test(marbles$epr_intens, marbles$group)
pairwise.wilcox.test(marbles$epr_linwid, marbles$group)
pairwise.wilcox.test(marbles$colour, marbles$group)
pairwise.wilcox.test(marbles$mgs, marbles$group)

