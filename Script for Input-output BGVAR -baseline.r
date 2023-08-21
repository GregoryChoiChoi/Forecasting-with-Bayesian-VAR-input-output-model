library(BGVAR)
library(dplyr)
## Converting data into time-series (next step: into List object)

#Sample code: a1 <- ts(a1, start = 1995, frequency = 4)

# a <- eerData[["EA"]]
#a1 <- as.data.frame(a) #become a data frame
#a1 <- ts(a1, start = 1995, frequency = 4)  #turn it back to time series for List

#Cubic interpolation:
y_df <- read.csv("output_at_basic_price.csv")
func = splinefun(x=y_df$date..output., y=y_df$Agriculture, method="fmm",  ties = mean) # Agri interpolation
y <- func(seq(1997, 2020, 0.25)) %>% unlist() %>% as.data.frame()
colnames(y)[colnames(y) == "."] <- "Agriculture" 

func = splinefun(x=y_df$date..output., y=y_df$Production, method="fmm",  ties = mean) # Production interpolation
y$Production <- func(seq(1997, 2020, 0.25)) %>% unlist() %>% as.data.frame()

func = splinefun(x=y_df$date..output., y=y_df$Construction, method="fmm",  ties = mean) # Construction interpolation
y$Construction <- func(seq(1997, 2020, 0.25)) %>% unlist() %>% as.data.frame()

func = splinefun(x=y_df$date..output., y=y_df$Distribution..transport..hotels.and.restaurants, method="fmm",  ties = mean) # Distribution..transport..hotels.and.restaurants interpolation
y[["Distribution..transport..hotels.and.restaurants"]] <- func(seq(1997, 2020, 0.25)) %>% unlist() %>% as.data.frame()

func = splinefun(x=y_df$date..output., y=y_df$Information.and.communication, method="fmm",  ties = mean) # Information.and.communication interpolation
y[["Information.and.communication"]] <- func(seq(1997, 2020, 0.25)) %>% unlist() %>% as.data.frame()

func = splinefun(x=y_df$date..output., y=y_df$Financial.and.insurance, method="fmm",  ties = mean) # Financial.and.insurance interpolation
y[["Financial.and.insurance"]] <- func(seq(1997, 2020, 0.25)) %>% unlist() %>% as.data.frame()

func = splinefun(x=y_df$date..output., y=y_df$Real.estate, method="fmm",  ties = mean) # Real.estate interpolation
y[["Real.estate"]] <- func(seq(1997, 2020, 0.25)) %>% unlist() %>% as.data.frame()

func = splinefun(x=y_df$date..output., y=y_df$Professional.and.support.activities, method="fmm",  ties = mean) # Professional.and.support.activities interpolation
y[["Professional.and.support.activities"]] <- func(seq(1997, 2020, 0.25)) %>% unlist() %>% as.data.frame()

func = splinefun(x=y_df$date..output., y=y_df$Government..health.and.education, method="fmm",  ties = mean) # Government..health.and.education interpolation
y[["Government..health.and.education"]] <- func(seq(1997, 2020, 0.25)) %>% unlist() %>% as.data.frame()

func = splinefun(x=y_df$date..output., y=y_df$Other.services, method="fmm",  ties = mean) # Other.services interpolation
y[["Other.services"]] <- func(seq(1997, 2020, 0.25)) %>% unlist() %>% as.data.frame()
y <- as.matrix(y)
y <- ts(y, start = 1997, frequency = 4)  #turn it back to time series for List

#Employment
n_df <- read.csv("Employment.csv")
n <- n_df[c(1:93),]
n <- ts(n, start = 1997, frequency = 4)  #turn it back to time series for List

#Build the list:
colnames(y) <- paste(colnames(y), "Y", sep = "_")
colnames(n) <- paste(colnames(n), "n", sep = "_")

Agriculture <- as.xts(log(cbind(y[,1], n[,1])))
colnames(Agriculture) <- c("y","n")
Production <- as.xts(log(cbind(y[,2], n[,2])))
colnames(Production) <- c("y","n")
Construction <- as.xts(log(cbind(y[,3], n[,3])))
colnames(Construction) <- c("y","n")
Distribution <- as.xts(log(cbind(y[,4], n[,4])))
colnames(Distribution) <- c("y","n")
Information <- as.xts(log(cbind(y[,5], n[,5])))
colnames(Information) <- c("y","n")
Financial <- as.xts(log(cbind(y[,6], n[,6])))
colnames(Financial) <- c("y","n")
RealEstate <- as.xts(log(cbind(y[,7], n[,7])))
colnames(RealEstate) <- c("y","n")
Professional <- as.xts(log(cbind(y[,8], n[,8])))
colnames(Professional) <- c("y","n")
Government <- as.xts(log(cbind(y[,9], n[,9])))
colnames(Government) <- c("y","n")
Other <- as.xts(log(cbind(y[,10], n[,10])))
colnames(Other) <- c("y","n")

#Naming is important in the package:
d <- list(Agriculture ,
            Production,
             Construction ,
             Distribution ,
             Information ,
             Financial ,
             RealEstate ,
             Professional ,
             Government ,
             Other)
names(d) <- c("Ag" ,
            "Pr",
             "Co" ,
             "Di" ,
             "In" ,
             "Fi" ,
             "Re" ,
             "PR" ,
             "Go" ,
             "Ot")
w <- read.csv("w.csv", header = FALSE)
w <- as.matrix(w)
rownames(w) <- c("Ag" ,
            "Pr",
             "Co" ,
             "Di" ,
             "In" ,
             "Fi" ,
             "Re" ,
             "PR" ,
             "Go" ,
             "Ot")
colnames(w) <- c("Ag" ,
            "Pr",
             "Co" ,
             "Di" ,
             "In" ,
             "Fi" ,
             "Re" ,
             "PR" ,
             "Go" ,
             "Ot")
#Run model: 
model.1 <- bgvar(Data = d, W = w, plag = 2, trend = TRUE)


model1.ssvs <- bgvar(Data = d, W = t(w), plag = 1,
                    hold.out = 8, thin = 2, draws = 1000, burnin = 1000, prior = "SSVS")

model2.mn <- bgvar(Data = d, W = w, plag = 2,
                hold.out = 8, thin = 2, draws = 1000, burnin = 1000, prior = "MN")

model3.hs <- bgvar(Data = d, W = t(w), plag = 3,
 hold.out = 8, thin = 2, draws = 1000, burnin = 1000, prior = "HS")


#Best fit line:
summary(model.1)
plot(model.1, global = TRUE)
#Forecast
fcast <- predict(model.1, n.ahead=8, save.store=TRUE)
plot(fcast, cut=8)
#IRF
shockinfo_girf<-get_shockinfo("girf")
shockinfo_girf$shock<-"In.y"
shockinfo_girf$scale <- +1
irf_girf <- BGVAR::irf(model.1, n.ahead = 24, shockinfo = shockinfo_girf)
plot(irf_girf)
