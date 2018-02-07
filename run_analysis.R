library(data.table)
library(dplyr)
#setting working directory
setwd(getwd())
#reading metadata
feaname <- read.table("UCI HAR Dataset/features.txt")
actlabel<- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
#reading train data
train_sub <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
train_act <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
train_fea <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
#reading test data
test_sub <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
test_act <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
test_fea <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
#merge train and test sets
sub <- rbind(train_sub, test_sub)
acti <- rbind(train_act, test_act)
head(acti)
fea <- rbind(train_fea, test_fea)
#merging all data into one
colnames(fea) <- t(feaname[2])
colnames(acti) <- "Activity"
colnames(sub) <- "Subject"
AllData <- cbind(fea,acti,sub)

#extract data with mean and sd
col_mean_sd <- grep(".*Mean.*|.*Std.*", names(AllData), ignore.case=TRUE)
needcol <- c(col_mean_sd, 562, 563)
dim(AllData)
extract_data <- AllData[,needcol]
dim(extract_data)

#give names to Activities in extract_data
extract_data$Activity <- as.character(extract_data$Activity)
for (i in 1:6){
  extract_data$Activity[extract_data$Activity == i] <- as.character(actlabel[i,2])
}
extract_data$Activity <- as.factor(extract_data$Activity)
names(extract_data)

#rename activities with right labels
names(extract_data)<-gsub("Acc", "Accelerometer", names(extract_data))
names(extract_data)<-gsub("Gyro", "Gyroscope", names(extract_data))
names(extract_data)<-gsub("BodyBody", "Body", names(extract_data))
names(extract_data)<-gsub("Mag", "Magnitude", names(extract_data))
names(extract_data)<-gsub("^t", "Time", names(extract_data))
names(extract_data)<-gsub("^f", "Frequency", names(extract_data))
names(extract_data)<-gsub("tBody", "TimeBody", names(extract_data))
names(extract_data)<-gsub("-mean()", "Mean", names(extract_data), ignore.case = TRUE)
names(extract_data)<-gsub("-std()", "STD", names(extract_data), ignore.case = TRUE)
names(extract_data)<-gsub("-freq()", "Frequency", names(extract_data), ignore.case = TRUE)
names(extract_data)<-gsub("angle", "Angle", names(extract_data))
names(extract_data)<-gsub("gravity", "Gravity", names(extract_data))

names(extract_data)

extract_data$Subject <- as.factor(extract_data$Subject)
extract_data <- data.table(extract_data)
#creating new data that is clean with mean of each activity subject and feature
cleandata <- aggregate(. ~Subject + Activity, extract_data, mean)
cleandata <- cleandata[order(cleandata$Subject,cleandata$Activity),]
write.table(cleandata, file = "cleandata.txt", row.names = FALSE)
