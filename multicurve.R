####### Multicurve fitter for ABC curves ####### 
# Paul Cuckoo Annalect 2016
# v1.3
# https://github.com/quantumness/work/blob/multi_ABC_curves/multicurve.R
# 

# Clear all loaded data
#rm(list=ls())

# Load data from CSV file
curvedata <- read.csv("R:/Knowledge and Data/5 Software and Tools/Tools/MultiCurve Fitter/CurveData.csv")
revcols <- ncol(curvedata)
curvecolname <- colnames(curvedata[c(2:(revcols))])

# Initial variables 
coefmain <- NULL
type <- rep("NLS",revcols)
coefY <- rep(0,3)
R2 <- NULL

# Minimise residual sum of squares function
min.RSS <- function(data, par) {
  with(data, sum(((par[1]/(1+par[2]*(x^par[3])))-y)^2))
}

# Calculate pseudo E2 value

fit <- function(data,par) {
  TSS <- sum((y-mean(y))^2)
  RSS <- with(data, sum(((par[1]/(1+par[2]*(x^par[3])))-y)^2))
  1-(RSS/TSS)
}


# Loop through revenue columns

for(i in 2:revcols){

  # Split data
  x <- unname(unlist(curvedata[1]))
  yi <- assign(paste("y", i, sep = ""), unname(unlist(curvedata[i])))
  y <- yi[!is.na(yi)]
  x <- x[c(1:length(y))]
  
  # Extract trial coefficients
  lm1 <- lm(log(max(y)/(y-1))~ 1+log(x))
  A <- max(y)
  B <- exp(coef(lm1)[1])
  C <- coef(lm1)[2] 
  
  dat <- data.frame(c(x), c(y))

  # Attempt to fit NLS model, if singular or other error, fit best alternative  
  tryCatch(coefy<-coef(nls(y ~ A/(1+B*(x)^C), start=list(A=A,B=B,C=C), control = list(maxiter = 5000))), error=function(e){
    result <- optim(par = c(max(y), exp(coef(lm1)[1]), coef(lm1)[2]), min.RSS, data = dat, method="BFGS")
    coefy <<- result$par
    type[i] <<- "OLS"
    })
  R2[i-1] <- fit(dat,coefy) #pseudo R2 value
  coefmain <- cbind(coefmain, coefy)
}
final.data <- rbind(R2,coefmain)

# Write CSV file
colnames(final.data) <- curvecolname
write.csv(final.data,"R:/Knowledge and Data/5 Software and Tools/Tools/MultiCurve Fitter/ABC.csv")
t(final.data)
