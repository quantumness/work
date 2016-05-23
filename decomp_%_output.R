####### Decomp % data extraction from PSA decomps ####### 
# ? Paul Cuckoo Annalect 2016
# v1.0
# <github link>
# 

# Uncomment to install Excel package if required
#install.packages("openxlsx")

setwd("R:/Clients/PSA Global/2016/4. Nameplate and Channel Modelling/Citroen UK decomp_test")
library(openxlsx)
library(plyr)
library(dplyr)
options(stringsAsFactors = FALSE)

# Load filenames and required data

filenames <- list.files(pattern = ".xlsm")
ws <- "Output"

summary.all <- NULL
split.all <- list()

# For each file...

for (i in 1:length(filenames)){
  
  # Read data, take filename and split data into summary and split
  all.data <- read.xlsx(filenames[i], ws, cols = seq(2,20), rows = c(7,seq(9,30)),colNames = FALSE)
  split.point <- which(apply(all.data, 1, function(r) any(r %in% c("Base"))))
  
  # Pull out other columns
  model.name <- strsplit(gsub(", |,"," ",strsplit(filenames[i],"Decomp")[[1]][1])," ")[[1]]
  
  
  # Process summary data
  summary.cont <- all.data[seq(split.point+1,dim(all.data)[1]),seq(1,5)]
  summary.data <- cbind(rep(model.name[1],dim(summary.cont)[1]),rep(model.name[2],dim(summary.cont)[1]),rep(model.name[3],dim(summary.cont)[1]),rep(model.name[4],dim(summary.cont)[1]),unname(summary.cont))
  summary.all <- rbind.fill(summary.all,summary.data)
  
  
  # Process split data
  
  split.cont <- all.data[-seq(split.point,dim(all.data)[1]),]
  split.data <- cbind(rep(model.name[1],dim(split.cont)[1]),rep(model.name[2],dim(split.cont)[1]),rep(model.name[3],dim(split.cont)[1]),rep(model.name[4],dim(split.cont)[1]),unname(split.cont))
  columnnames <- c("Market","Brand","Nameplate","KPI","Year",split.data[1,-seq(1,5)])
  split.data <- split.data[-1,]
  colnames(split.data) <- columnnames
  row.names(split.data) <- NULL
  split.all[[i]] <- split.data
  
  
}

# Bind column names and rows and export to CSV

colnames(summary.all) <- c("Market","Brand","Nameplate","KPI","Year","Base","Leads","Direct media", "Halo media")
split.final <- bind_rows(split.all)
write.csv(summary.all,"Decomp Summary Output.csv")
write.csv(split.final,"Decomp Split Output.csv")







