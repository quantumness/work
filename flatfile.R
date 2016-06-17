#####################################################
# Flat file creator
# Paul Cuckoo - Annalect 2016
# v1.0
#####################################################


# Set up processing

library(plyr)
library(dplyr)
rm(list=ls())

# Needed variables

flat.finalcols1 <- NULL
flat.finalcols2 <- NULL

#####################################################
# Parameters

setwd("P:/")
table.all <- read.csv("table.csv", header=FALSE)
rows <- 3 #how many rows down from the top the data runs
cols <- 2 #how many cols from the left are not data

#####################################################


# Data proc

table.data <- table.all[seq(rows+1,dim(table.all)[1]),seq(cols+1,dim(table.all)[2])]
flat.values <- unname(unlist(c(table.data)))

# Values proc

table.rows <- table.all[seq(1,rows),seq(cols+1,dim(table.all)[2])]
flat.rowcols <- t(table.rows)
flat.colcols <- table.all[seq(rows+1,dim(table.all)[1]),seq(1,cols)]

# Assemble flat file

for (k in 1:dim(flat.rowcols)[1]) {
  

  for (j in 1:dim(flat.colcols)[1]) {
  
    flat.finalcols1 <- rbind(flat.finalcols1,flat.rowcols[k,])
  
  }
  
  flat.finalcols2 <- rbind(flat.finalcols2,flat.colcols)
}

flat.file <- as.data.frame(cbind(flat.finalcols1,flat.finalcols2,flat.values))

# Tidy and export 

colnames(flat.file) <- NULL
row.names(flat.file) <- NULL
write.csv(flat.file,"flatfile.csv")

