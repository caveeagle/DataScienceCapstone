
library('Matrix')

setwd("D:\\!Data Science\\Capstone\\objects")

bdata <- readRDS( file = "full_business.rds" )

udata <- readRDS( file = "full_users.rds" )

rdata <- readRDS( file = "full_review.rds" )

sparse <- readRDS( file = "sparse_matrix_object.rds" )

X <- readRDS( file = "svd_object.rds" )

#################################################
#################################################

library(pryr)
mem_used()

#################################################
#################################################
#################################################
#################################################

U <- udata[order(-udata$review_count),]

U[1000:1010,]

# for user Kim, N=3631, Id=KsC9e-B-te0F9nf1A21Gmw  city=Las Vegas

rdata_find <- rdata[ rdata$user_id=="KsC9e-B-te0F9nf1A21Gmw",]

bdata_find <- bdata[  bdata$business_id %in% rdata_find$business_id , ]

cats <- unlist(bdata_find$categories)

sm_cats <- as.data.frame(summary(as.factor(cats)))
colnames(sm_cats) <- c("nums")
sm_cats <- cbind(cats = rownames(sm_cats), sm_cats)
sm_cats <- sm_cats[order(-sm_cats$nums),]


# Like: Casinos, Arts & Entertainment

#################################################
#################################################
#################################################
#################################################

#R <- X$u %*% t(X$v) 

# crossprod(X$u,X$v)

#################################################
#################################################




















