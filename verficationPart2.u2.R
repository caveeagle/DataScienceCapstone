
library('Matrix')

setwd("D:\\!Data Science\\Capstone\\objects")

bdata <- readRDS( file = "full_business.rds" )

X <- readRDS( file = "svd_object.rds" )

# tw <- as.data.frame(summary(as.factor(bdata$city)))

#################################################
#################################################

uN <- X$u[3631,] # for Kim

RN <- uN %*% t(X$v) # Recommendation for Kim

R <- matrix(RN,ncol = 1)
R <- cbind(R,c(1:61184))
R <- as.data.frame(R)
R <- R[order(-R$V1),]

#################################################
#################################################

Rsub <- R[ 1:100  ,]

bdata_find_R <- bdata[  (bdata$N %in% Rsub$V2) & (! bdata$N %in% bdata_find$N) , ]

#################################################
#################################################

cats_R <- unlist(bdata_find_R$categories)

sm_cats_R <- as.data.frame(summary(as.factor(cats_R)))
colnames(sm_cats_R) <- c("nums")
sm_cats_R <- cbind(cats_R = rownames(sm_cats_R), sm_cats_R)
sm_cats_R <- sm_cats_R[order(-sm_cats_R$nums),]


#################################################
# for user Kim
#################################################























