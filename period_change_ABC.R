####### ABC periodicity changer ####### 
# Paul Cuckoo Annalect 2016
# v1.0
# 

# Clear all loaded data
#rm(list=ls())


#######################################################################
# Enter perodicity details here by number of days, 
# eg weekly = 7, monthly = 30.44, or any custom amount
#
# 
#
period.from <- 7
period.to <- 30.44 
#
######################################################################

# Load data from CSV file
ABCdata <- read.csv("R:/Knowledge and Data/5 Software and Tools/Tools/MultiCurve Fitter/ABC.csv")

# Remove R2 if using formatted ABC file
if(ABCdata[1,1]=="R2") {
  ABCdata <- ABCdata[-1,-1]
  row.names(ABCdata) <- c("a","b","c")
}


# Create revised ABC table
ABCnew <- ABCdata

# Amend A variable
for (k in 1:ncol(ABCdata)){
  ABCnew[1,k] <- ABCdata[1,k] * period.to / period.from
}

# Export new ABC table
write.csv(ABCnew,"R:/Knowledge and Data/5 Software and Tools/Tools/MultiCurve Fitter/ABCnew.csv")



