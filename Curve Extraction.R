# Media curve extraction from PSA decomps
# Paul Cuckoo / Annalect 2016



setwd("R:/Clients/PSA Global/2015/4. Nameplate and Channel Modelling/Peugeot/Analysis and Results")


library(openxlsx)

filenames <- list.files(pattern = ".xlsm")
ws <- "Calculation"
column.data.names <- NULL
column.data.all <- NULL
model.name <- NULL
denom <- NULL
adstock <- NULL
functional.split <- NULL

for (i in 1:length(filenames)){
  column.data <- read.xlsx(filenames[i], ws, cols = c(8,9),colNames = FALSE)
  model.name[i] <- gsub("[,]"," ",strsplit(filenames[i],"Decomp")[[1]][1])
  column.data.names <- cbind(rep(model.name[i],dim(column.data)[1]),unname(column.data))
  column.data.all <- rbind(column.data.all,column.data.names) 
}
column.data.media <- column.data.all[grep("1-EXP",column.data.all[,2]),]

for (j in 1:dim(column.data.media)[1]){
  functional.split[j] <- strsplit(column.data.media[j,2],"[/]")
  denom[j] <- as.integer(gsub(")","",functional.split[[j]][2]))
  adstock[j] <- gsub(")|-1|-2|-3|-4|_|[(]","",functional.split[[j]][1])
  adstock[j] <- suppressWarnings(as.numeric(substring(adstock[j], nchar(adstock[j])-1, nchar(adstock[j]))))
}
final.data <- cbind(unname(column.data.media),denom,adstock)
rownames(final.data) <- NULL
colnames(final.data) <- c("Model name", "Functional form", "Coefficient", "Denominator", "Adstock")