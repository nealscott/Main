# Import libraries, source functions.

library(lattice)

library(MASS)

source("http://www.phaget4.org/R/myImagePlot.R")
source('~/desktop/6002R/Resources/FactorPlots.R')
source('~/desktop/6002R/Resources/SPM_Panel.R')
source('~/desktop/6002R/Resources/AccidentInput.R')
source('~/desktop/6002R/Resources/FactorPlots.R')
source('~/desktop/6002R/Resources/pc.glm.R')
source('~/desktop/6002R/Resources/PCAplots.R')
source('~/desktop/6002R/Resources/ROC.R')
source('~/desktop/6002R/Resources/TestSet.R')
seed <- read.table("~/Desktop/6002R/Resources/class.seed");
.Random.seed <- t(seed)


# import & manage data. 

readmits <- read.csv("~/Desktop/6002R/Data/readmits.csv", header = TRUE, 
 	sep = ",", quote="\"", dec=".", fill = TRUE, comment.char="",)

discharges <- read.csv("~/Desktop/6002R/Data/DISCHARGES.csv", header = TRUE, 
	sep = ",", quote="\"", dec=".", fill = TRUE, comment.char="",)

discharges_old <- read.csv("~/Desktop/6002R/Data/DISCHARGES_OLD.csv", header = TRUE, 
                       sep = ",", quote="\"", dec=".", fill = TRUE, comment.char="",)

rstudio::viewData(readmits)

rstudio::viewData(discharges)

# Create Subsets

# xreadmissions <-subset(readmits, DRG_PREV!='O')

# rm(xreadmissions)

expBetas <- function(x)
{ 
  (exp(x)-1)*100
}
