####### ABC periodicity changer ####### 
# Paul Cuckoo Annalect 2016
# v1.0
# 

# Clear all loaded data
rm(list=ls())

# Load data from CSV file and tidy
ABCdata <- read.csv("R:/Knowledge and Data/5 Software and Tools/Tools/MultiCurve Fitter/ABC.csv")
row.names(ABCdata) <- c("w","a","b","c")
ABCdata <- ABCdata[,-1]


# Select x0 (average spend)
x0 <- 5000000

# Other needed variables

D <- NULL
A <- NULL
B <- NULL
C <- NULL
w <- NULL

# Extract weights and variables
for (i in 1:ncol(ABCdata)){
  A[i] <- ABCdata[2,i]
  B[i] <- ABCdata[3,i]
  C[i] <- ABCdata[4,i]
  w[i] <- ABCdata[1,i]
  D[i] <- B[i]/(x0^C[i])
}

# Calculate alpha, beta, gamma
alpha <- sum(A/(1+D))
beta <- sum(-(A*D*C)/((1+D)^2))
gamma <- sum(A*(((2*D^2*C^2)/((1+D)^3))-((D*C*(C-1))/((1+D)^2))))


# Calculate A*, B*, C*

A.new <- alpha*(alpha*beta + alpha*gamma - 2*beta^2)/(alpha*beta + alpha*gamma - beta^2)
D.new <- -beta^2/(alpha*beta + alpha*gamma - beta^2)
C.new <- (alpha*beta + alpha*gamma - 2*beta^2)/(alpha*beta)
B.new <- D.new*(x0^C.new)

ABCnew <- cbind(ABCdata,rbind(1,A.new,B.new,C.new))
colnames(ABCnew)[ncol(ABCnew)] <- "Weighted average"
ABCnew

