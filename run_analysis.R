library(reshape2)

Zipfile <- "getdata_dataset.zip"
# Download source data
if (!file.exists(Zipfile)){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(url, Zipfile, method="curl")}  
# Unzip the dataset
if (!file.exists("UCI HAR Dataset")) { 
  unzip(Zipfile) }

#Reading activity label
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
# Reading feature vector
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
mean_and_std <- grep(".*mean.*|.*std.*", features[,2])
mean_and_std.names <- features[mean_and_std,2]
mean_and_std.names = gsub('-mean', 'Mean', mean_and_std.names)
mean_and_std.names = gsub('-std', 'Std', mean_and_std.names)
mean_and_std.names <- gsub('[-()]', '', mean_and_std.names)

# Reading trainings tables:
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")[ mean_and_std]
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(subject_train, y_train, x_train)

# Reading testing tables:
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")[ mean_and_std]
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(subject_test, y_test, x_test)

# merge datasets and add labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", mean_and_std.names)

#independent tidy data set with the average of each variable for each activity and each subject
#turn activities & subjects into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)
allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
