setwd("C:\\Documents\\Data science\\Cleaning data\\Project\\UCI HAR Dataset")
## acquiring the data
colHeaders <- read.delim("features.txt", sep="", header=FALSE)
subjectTest <- read.delim("test\\subject_test.txt", sep="", header=FALSE, col.names="subjectId")
subjectTrain <- read.delim("train\\subject_train.txt", sep="", header=FALSE, col.names="subjectId")
activityTest <-read.delim("test\\Y_test.txt", sep="", header=FALSE, col.names="activityId")
activityTrain <- read.delim("train\\Y_train.txt", sep="", header=FALSE, col.names="activityId")
activityLabels <- read.delim("activity_labels.txt", sep="", header=FALSE, col.names=c("activityId","activityDesc"))
testSet <- read.delim("test\\X_test.txt", sep="", header=FALSE)
trainSet <- read.delim("train\\X_train.txt", sep="", header=FALSE)

## assignment part 4 meaningful variable names
colnames(testSet) <- colHeaders[,2]
colnames(trainSet) <- colHeaders[,2]

## assignment part 1: merge the datasets
testSet <- cbind(subjectTest, activityTest, testSet)
trainSet <- cbind(subjectTrain, activityTrain, trainSet)

## assignment part 3 descriptive activity names
testSet <- merge(activityLabels,testSet,by="activityId")
trainSet <- merge(activityLabels,trainSet,by="activityId")

mergedSet <- rbind(testSet,trainSet)

## assignment part 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
subsetMean <- grepl("mean()",colnames(mergedSet), fixed=TRUE)
subsetStd <- grepl("std()", colnames(mergedSet), fixed=TRUE)
subsetAll <- as.logical(subsetMean + subsetStd)
# also keep Subject ID and activity description!
subsetAll[2:3] <- TRUE
subMergedSet <- mergedSet[,subsetAll]
#subMergedSet[with(order(subMergedSet$subjectId,subMergedSet$activityDesc)),]
tidySet <- aggregate(. ~ subMergedSet$subjectId+subMergedSet$activityDesc, data=subMergedSet ,FUN=mean)
#rename the columns from the aggregate function and remove other ones
tidySet <- tidySet[,-c(3,4)]
colnames(tidySet)[1:2] <- c("subjectId","activity")

# now write the output
write.table(tidySet, "tidySet.txt", row.name=FALSE)
