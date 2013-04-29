# Models and outputs

# Logistic Regression - 30 Day Readmits

# Test Set

TSdischarges <- test.set(discharges, .33)

discharges.train <- data.frame(TSdischarges$train)

barplot(table(TSdischarges$train$READMIT_30), xlab = "Email Classfication", main = "Discharges in Training Set", names.arg = c("Clear", "Back in 30"), col = "steelblue")

# Stepwise Regression - For Overview

discharges.overview <- glm(READMIT_30~., data = discharges.train[,c(2:9,11:21,23:27, 28)], family = binomial)

sink(file="~/Desktop/6002R/Visualizations/DischargesOverview30.txt")
summary(discharges.overview)
sink()

discharges.step <- step(discharges.overview)

sink(file="~/Desktop/6002R/Visualizations/DischargesStep30.txt")
summary(discharges.step)
sink()

sink(file="~/Desktop/6002R/Visualizations/DischargesAnova30.txt")
anova(discharges.overview, discharges.step, test = "Chi")
sink()

# 60-Day

discharges.overview <- glm(READMIT_60~., data = discharges.train[,c(2:9,11:21,23:27, 28)], family = binomial)
discharges.step <- step(discharges.overview)

sink(file="~/Desktop/6002R/Visualizations/DischargesOverview60.txt")
summary(discharges.overview)
sink()

discharges.step <- step(discharges.overview)

sink(file="~/Desktop/6002R/Visualizations/DischargesStep60.txt")
summary(discharges.step)
sink()

sink(file="~/Desktop/6002R/Visualizations/DischargesAnova60.txt")
anova(discharges.overview, discharges.step, test = "Chi")
sink()

# All Readmits

discharges.overview <- glm(READMIT~., data = discharges.train[,c(2:9,11:21,23:27, 28)], family = binomial)

sink(file="~/Desktop/6002R/Visualizations/DischargesOverviewAll.txt")
summary(discharges.overview)
sink()

discharges.stepall <- step(discharges.overview)

sink(file="~/Desktop/6002R/Visualizations/DischargesStepAll.txt")
summary(discharges.step)
sink()

sink(file="~/Desktop/6002R/Visualizations/DischargesAnovaAll.txt")
anova(discharges.overview, discharges.step, test = "Chi")
sink()

# Main Effects 

discharges.main <- glm(READMIT_30~., data = discharges.train[,c(2,3,4,6,7,8,9,11,13,14,18,19,21,24,26,27,28)], family = binomial)

sink(file="~/Desktop/6002R/Visualizations/Main.txt")
summary(discharges.main)
sink()

sink(file="~/Desktop/6002R/Visualizations/DischargesAnova.txt")
anova(discharges.main, discharges.step, test = "Chi")
sink()

# Convert Coefficients

discharges.main$names

sink(file="~/Desktop/6002R/Visualizations/BetaMain.txt")
expBetas(discharges.main$coefficients)
sink()

# Validation

# Diagnostic Plots

png(filename = '~/Desktop/6002R/Visualizations/Diagnostics.png', width = 960, height = 960, units = "px", res = NA, pointsize = 12,)
par(mfrow = c(2,2))
plot(discharges.main)
par(mfrow = c(1,1))
dev.off()

# Score Tables

# test set prediction

glm.pred <- predict(discharges.main, newdata = TSdischarges$test, type = "response")

summary(glm.pred)

# here is an example with threshold = .5

sink(file="~/Desktop/6002R/Visualizations/DischargesScore.txt")
score.table(glm.pred, TSdischarges$test[,"READMIT_30"],  .5)
sink()

#   ROC Curves

# with the example above

png(filename = '~/Desktop/6002R/Visualizations/ROC.png', width = 960, height = 960, units = "px", res = NA, pointsize = 48,)
plot.roc(glm.pred, TSdischarges$test[,"READMIT_30"], main = "ROC Curve - Readmissions Prediction")
dev.off()
 
# legend(.6, .4, legend = c("Model 1", "Model 2"), col = c("blue", "orange"), lwd = 1)

# export tables:

sink(file="~/Desktop/6002R/Visualizations/BetaMain.txt")
xtable(summary(discharges.main),type = "html")
sink()

# Visualizations:

png(filename = '~/Desktop/6002R/Visualizations/PrevCondBarchart.png', width = 480, height = 480, units = "px", res = NA, pointsize = 12,)
barchart(discharges_old$DRG_CURRENT)
dev.off()

