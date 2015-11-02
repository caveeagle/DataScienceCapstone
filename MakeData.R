
library(devtools)

library(jsonlite)

library(dplyr)

setwd("D:\\!Data Science\\Capstone")

dataDir <- ".\\yelp_dataset_challenge_academic_dataset"

objectsDir <- ".\\objects"

################################
################################

file_json = file(paste0(dataDir,
                        "/yelp_academic_dataset_business.json"))

file_rds = file(paste0(objectsDir,
                       "/full_business.rds"))

DATA<-stream_in(file_json)

DATA <- flatten(DATA)

DATA$N <- 1:nrow(DATA) 

colnum <- 1:(ncol(DATA)-1)

colnum <- c(ncol(DATA),colnum)

DATA <- DATA[,colnum]

saveRDS(DATA, file = file_rds )

################################
################################


################################
################################

file_json = file(paste0(dataDir,
"/min_yelp_academic_dataset_user.json"))

file_rds = file(paste0(objectsDir,
"/min_users.rds"))

DATA<-stream_in(file_json)

DATA <- flatten(DATA)

DATA$N <- 1:nrow(DATA) 

DATA <- DATA[,c("N","user_id","name","review_count","average_stars")]

saveRDS(DATA, file = file_rds )

################################
################################

file_json = file(paste0(dataDir,
                       "/min_review_withot_text.json"))

file_rds = file(paste0(objectsDir,
                       "/min_review.rds"))

DATA<-stream_in(file_json)

DATA <- flatten(DATA)

DATA$N <- 1:nrow(DATA) 

#DATA <- DATA[,!(names(DATA) %in% c("text"))]

saveRDS(DATA, file = file_rds )

################################
################################











