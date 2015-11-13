
############# GENERAL PART #####################

setwd("D:\\!Data Science\\Capstone\\objects")

bdata <- readRDS( file = "full_business.rds" )

udata <- readRDS( file = "full_users.rds" )

rdata <- readRDS( file = "full_review.rds" )

X <- readRDS( file = "svd_object.rds" )

#################################################
#################################################
#################################################
#################################################

############# MAIN FUNCTION #####################

makeCategories <- function(n) {

#### ONE USER (PART 1)

user_num <- n

user_uid <- udata[user_num,2] 

### MAKE sm_cats

rdata_find <- rdata[ rdata$user_id==user_uid,]
bdata_find <- bdata[  bdata$business_id %in% rdata_find$business_id , ]
cats <- unlist(bdata_find$categories)
sm_cats <- as.data.frame(summary(as.factor(cats)))
colnames(sm_cats) <- c("nums")
sm_cats <- cbind(cats = rownames(sm_cats), sm_cats)
sm_cats <- sm_cats[order(-sm_cats$nums),]
row.names(sm_cats)<-NULL

### CALC RECOMENDATION (PART 2)

uN <- X$u[user_num,] 

RN <- uN %*% t(X$v) # Recommendation for user

R <- matrix(RN,ncol = 1)
R <- cbind(R,c(1:61184))
R <- as.data.frame(R)
R <- R[order(-R$V1),]

user_maxcat <- nrow(bdata_find) # Number of recomendation categories

Rsub <- R[ 1:user_maxcat,]

bdata_find_R <- bdata[  (bdata$N %in% Rsub$V2) & (! bdata$N %in% bdata_find$N) , ]

### MAKE sm_cats_R

cats_R <- unlist(bdata_find_R$categories)

sm_cats_R <- as.data.frame(summary(as.factor(cats_R)))
colnames(sm_cats_R) <- c("nums_recommend")
sm_cats_R <- cbind(cats_R = rownames(sm_cats_R), sm_cats_R)
sm_cats_R <- sm_cats_R[order(-sm_cats_R$nums_recommend),]
row.names(sm_cats_R)<-NULL

### RETURN matrix

res <- nrow(sm_cats) - nrow(sm_cats_R)

if(res>0)
{
  fill <- matrix(c("",0),nrow=res,ncol=2,byrow=TRUE)
  colnames(fill) <- c("cats_R","nums_recommend")
  sm_cats_R <- rbind(sm_cats_R,fill)
}

if(res<0)
{
  res = -res
  fill <- matrix(c("",0),nrow=res,ncol=2,byrow=TRUE)
  colnames(fill) <- c("cats","nums")
  sm_cats <- rbind(sm_cats,fill)
}

CATEGORIES <- cbind(sm_cats,sm_cats_R)
colnames(CATEGORIES) <- c("known_categories","known_nums","recommend_categories","recommend_nums")

return( CATEGORIES )
}

#################################################
#################################################
#################################################
#################################################

############ MAKE USERS LIST ####################

udata <- udata[order(-udata$review_count),]

USERS_LIST <- udata[1:1000,1]

################   MAIN CYCLE ###################

#USERS_LIST <- c(2809,3631)

CATEGORIES_LIST = list()

for(n in USERS_LIST)
{
  CATEGORIES_LIST[[length(CATEGORIES_LIST)+1]] <- makeCategories(n)
}

saveRDS(CATEGORIES_LIST, file = "check_categories_list.rds" )

#################################################
#################################################
#################################################
#################################################

#CAT <- CATEGORIES_LIST[[1]]












