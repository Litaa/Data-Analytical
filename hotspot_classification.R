
titikpanas <- read.csv("E:/firms3350314631282061_NRT.csv")
View(titikpanas)

data.hotspot <- titikpanas
data.hotspot$geom <- NULL
data.hotspot$longitude <- NULL
data.hotspot$latitude <- NULL
data.hotspot$scan <- NULL
data.hotspot$track <- NULL
data.hotspot$acq_date <- NULL
data.hotspot$acq_time <- NULL
data.hotspot$satellite <- NULL
data.hotspot$version <- NULL
data.hotspot$frp <- NULL

View(data.hotspot)

#binning data
#range (-1 - 29) (30 - 79) (80 - 100)
data.hotspot$confidenceC <- cut (data.hotspot$confidence, c(-1,29,79,100))
View(data.hotspot)

library(infotheo)

# discretization process binning result into 3 class
#class 1 -> 0 <= confidence < 30
#class 2 -> 30 <= confidence < 80
#class 3 -> 80 <= confidence < 100
data.hotspot$confidence <- discretize(as.data.frame(data.hotspot$confidenceC), "equalwidth", 3)
View(data.hotspot)

#create data matrix
data.hotspot$confidence <- data.matrix(data.hotspot$confidence)
View(data.hotspot)

data.hotspot$confidenceC <- NULL

train <- data.hotspot[1:935,]
test <- data.hotspot[936:1169,]

View(train)

label_train <- train$confidence
label_train

label_test <- test$confidence
label_test

library(class)

result <- knn(train, test, label_train, k=5)
result

table(result, label_test)

plot(result)






