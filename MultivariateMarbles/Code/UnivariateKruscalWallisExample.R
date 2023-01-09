data <- PlantGrowth

levels(data$group)

head(data)
data$group <- ordered(data$group,
                      levels = c("ctrl", "trt1", "trt2"))
head(data)# The weights are still not ordered. 

library(dplyr)
group_by(data, group) %>%
  summarise(
    count = n(),
    mean = mean(weight, na.rm = TRUE),
    sd = sd(weight, na.rm = TRUE),
    median = median(weight, na.rm = TRUE),
    IQR = IQR(weight, na.rm = TRUE)
  )


library("ggpubr")
ggboxplot(data, x = "group", y = "weight",
          color = "group", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          order = c("ctrl", "trt1", "trt2"),
          ylab = "Weight", xlab = "Treatment")

# Using \alpha =.5

# Kruscal tests if there are signnifcant differences between the 
# groups. 
kruskal.test(weight ~ group, data = data)

# We can conclude that there are significant differences between 
# the treatment groups because the p-value is less than the 
# significance criterion of 0.05.


# Now let's take a more focused approach 

### Wilcoxon Tests
# tests if there are differences between two dependent samples (groups)
# Is the non-parametric counterpart to the t-test for dependent samples
# Both of these non-parametric samples do not require normality. 


# Wilcoxon looks at the difference of ranks. 
pairwise.wilcox.test(PlantGrowth$weight, PlantGrowth$group,
                     p.adjust.method = "BH")


