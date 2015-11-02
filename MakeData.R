
library(devtools)

library(jsonlite)

library(dplyr)

setwd("D:\\!Data Science\\Capstone")

dataDir <- ".\\yelp_dataset_challenge_academic_dataset"

objectsDir <- ".\\objects"

################################

file_json = file(paste0(dataDir,
"/yelp_academic_dataset_user.json"))

file_rds = file(paste0(objectsDir,
"/full_users.rds"))

DATA<-stream_in(file_json)

DATA <- flatten(DATA)

DATA <- DATA[,c("user_id","name","review_count","average_stars")]

saveRDS(DATA, file = file_rds )

################################
################################

file_json = file(paste0(dataDir,
                        "/yelp_academic_dataset_review.json"))

file_rds = file(paste0(objectsDir,
                       "/review_withot_text.json"))

DATA<-stream_in(file_json)

DATA <- flatten(DATA)

#DATA <- DATA[,!(names(DATA) %in% c("text"))]

saveRDS(DATA, file = file_rds )

################################
################################











