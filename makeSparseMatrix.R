
setwd("D:\\!Data Science\\Capstone\\objects")

#################################################
#################################################

bdata <- readRDS( file = "full_business.rds" )

udata <- readRDS( file = "full_users.rds" )

rdata <- readRDS( file = "full_review.rds" )

#################################################
#################################################

b_uids <- bdata$business_id

u_uids <- udata$user_id

#################################################
#################################################

library('Matrix')

sparse <- Matrix(0, nrow = nrow(udata), ncol = nrow(bdata), sparse = TRUE)

#################################################
#################################################


########################

library(doSNOW)

pb <- txtProgressBar(min = 1, max = 100, style = 3)

#################################################
#################################################

fn <- function(rI)
{
  setTxtProgressBar(pb, rI)
  c(match(rdata[rI,"user_id"],u_uids),
               match(rdata[rI,"business_id"],b_uids),
               rdata[rI,"stars"])
}

RES <- foreach(rI = 1:100, .combine=rbind) %do% fn(rI)

#################################################
#################################################

file_sparse_rds = "D:\\!Data Science\\Capstone\\objects\\sparse_matrix_RAW.rds"
saveRDS(RES, file = file_sparse_rds )


#################################################
