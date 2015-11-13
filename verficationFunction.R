
#### GENERAL PART

setwd("D:\\!Data Science\\Capstone\\objects")

bdata <- readRDS( file = "full_business.rds" )

udata <- readRDS( file = "full_users.rds" )

rdata <- readRDS( file = "full_review.rds" )

X <- readRDS( file = "svd_object.rds" )

#################################################
#################################################
#################################################
#################################################

#### ONE USER (PART 1)

user_num = 2809

user_uid = udata[user_num,2] ????

user_maxcat = 100 # Number of recomendation categories

### MAKE sm_cats

rdata_find <- rdata[ rdata$user_id==user_uid,]
bdata_find <- bdata[  bdata$business_id %in% rdata_find$business_id , ]
cats <- unlist(bdata_find$categories)
sm_cats <- as.data.frame(summary(as.factor(cats)))
colnames(sm_cats) <- c("nums")
sm_cats <- cbind(cats = rownames(sm_cats), sm_cats)
sm_cats <- sm_cats[order(-sm_cats$nums),]

### CALC RECOMENDATION

uN <- X$u[user_num,] 

RN <- uN %*% t(X$v) # Recommendation for user

R <- matrix(RN,ncol = 1)
R <- cbind(R,c(1:61184))
R <- as.data.frame(R)
R <- R[order(-R$V1),]

Rsub <- R[ 1:user_maxcat,]

bdata_find_R <- bdata[  (bdata$N %in% Rsub$V2) & (! bdata$N %in% bdata_find$N) , ]

### MAKE sm_cats_R

cats_R <- unlist(bdata_find_R$categories)

sm_cats_R <- as.data.frame(summary(as.factor(cats_R)))
colnames(sm_cats_R) <- c("nums_recommend")
sm_cats_R <- cbind(cats_R = rownames(sm_cats_R), sm_cats_R)

### RETURN matrix

CATEGORIES = cbind(sm_cats,sm_cats_R)


#################################################
#################################################
#################################################
#################################################
















