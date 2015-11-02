
setwd("D:\\!Data Science\\Capstone\\objects")

#################################################
#################################################

bdata <- readRDS( file = "min_business.rds" )

udata <- readRDS( file = "min_users.rds" )

rdata <- readRDS( file = "min_review.rds" )

#################################################
#################################################

udata$N <- 1:nrow(udata) 

bdata$N <- 1:nrow(bdata) 

rdata$N <- 1:nrow(rdata) 

#################################################
#################################################

library('Matrix')

sparse <- Matrix(0, nrow = nrow(udata), ncol = nrow(bdata), sparse = TRUE)

#################################################
#################################################

count = 0

for (rI in 1:nrow(rdata))
{
  user_num <- 0
  bus_num <- 0
  for (uI in 1:nrow(udata))
  {
      if( rdata[rI,"user_id"] ==  udata[uI,"user_id"] )
      {
        user_num <- udata[uI,"N"]
        break
      }
  }
  for (bI in 1:nrow(bdata))
  {
    if( rdata[rI,"business_id"] ==  bdata[bI,"business_id"] )
    {
      bus_num <- bdata[bI,"N"]
      break
    }
  }

  if(user_num==0)
  {
    #message("ERROR IN REVIEW (USER NOT FIND): ",rdata[rI,"N"])
    break
  }
  if(bus_num==0)
  {
    #message("ERROR IN REVIEW (BUSINESS NOT FIND): ",rdata[rI,"N"])
    break
  }
  
  conut += 1
  
  if( (count%1000) == 0 )
  {
    print(count%1000)
  }
  
  print(user_num)
  print(bus_num)
  
  # sparse[user_num,bus_num] = rdata[rI,"stars"]
  
  if(count>10000) break; # for debug
  
}

#################################################
#################################################

# object.size(sparse)
# head(sparse)

###############################################################################
###############################################################################

file_sparse_rds = "D:\\!Data Science\\Capstone\\objects\\sparse.rds"

saveRDS(sparse, file = file_sparse_rds )

###############################################################################
###############################################################################

















