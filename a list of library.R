#library(writexl)
library(plm)
library(mice)
library(systemfit)
library(lubridate)
library(readxl)
library(readr)
library(tidyverse)
library(fuzzyjoin)
library(ggplot2)
library(stringr)
library(dplyr)
library(tidyr)
library(zoo)
library(Ecdat)
library(mgsub)
library(magrittr)
#library("data.table")
library(MatchIt)
library(stringr) #https://stackoverflow.com/questions/10294284/remove-all-special-characters-from-a-string-in-r
library(stringi) #https://stackoverflow.com/questions/13863599/insert-a-character-at-a-specific-location-in-a-string
library(lmtest) # standard
library(AER) # standard metric package
library(skedastic) #BP test
library(rstatix) # shapiro normality test
library(ggpubr) #ggdensity normality check
#library(orcutt) #for transformation
library(whitestrap) # https://github.com/jlopezper/whitestrap
library(sandwich)
library(tseries) # time series
library(xts)
#library(Synth) #For synthetic control 1
#library(gsynth) # For synthetic control 2
#library(vars) #VAR package
#library(forecast) # auto.arima() quick and duty way of forecasting
#library(BVAR) #BVAR
#library(BGVAR) #GBVAR
library(mlogit)
#library(haven) # read dta
library(tidytext) #Text mining
#library(janeaustenr) # Text mining
#library(Hmisc)
#library(stat)
#compare dataset (Use ifelse)
library(cobalt)
library(FactoMineR)
library(factoextra)
library(marginaleffects)
library(boot)
library(glmnet)
library(wordcloud)
library(robustbase) # outliers
library(quantreg) # outliers
library(Synth) #synthetic control:
library(mfbvar)
options(scipen = 999)
options(timeout = max(1000, getOption("timeout")))