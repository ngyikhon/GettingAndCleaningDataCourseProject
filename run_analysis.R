## Loading required packages
list.of.packages <- c("RCurl", "data.table")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library(RCurl)
library(data.table)

## Setting the filename to download
filename <- "getdata_projectfiles_UCI_HAR_Dataset.zip"

## Step 1:  Download and unzip the dataset
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, destfile=filename, method="auto", mode="wb", quiet = TRUE)
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

## Step 2:  Loaded test and training data sets into data frames

## Step 2.1 Load Test Data
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt")
X_test = read.table("UCI HAR Dataset/test/X_test.txt")
Y_test = read.table("UCI HAR Dataset/test/Y_test.txt")

## Step 2.2 Load Training Data
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt")
X_train = read.table("UCI HAR Dataset/train/X_train.txt")
Y_train = read.table("UCI HAR Dataset/train/Y_train.txt")

## Step 3:  Loaded source variable names for test and training data sets
features <- read.table("UCI HAR Dataset/features.txt", col.names=c("featureId", "featureLabel"))

## Step 4:  Loaded activity labels
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("activityId", "activityLabel"))
activities$activityLabel <- gsub("_", "", as.character(activities$activityLabel))

## Step 5:  Combined test and training data frames using rbind
subject <- rbind(subject_test, subject_train)
X <- rbind(X_test, X_train)
Y <- rbind(Y_test, Y_train)

## Step 6:  Paired down the data frames to only include the mean and standard deviation variables
includedFeatures <- grep("-mean\\(\\)|-std\\(\\)", features$featureLabel)
X <- X[, includedFeatures]
names(subject) <- "subjectId"
names(X) <- gsub("\\(|\\)", "", features$featureLabel[includedFeatures])
names(Y) = "activityId"

## Step 7:  Replaced activity IDs with the activity labels for readability
activity <- merge(Y, activities, by="activityId")$activityLabel
  
## Step 8:  Combined the data frames to produce one data frame containing the subjects, measurements and activities
data <- cbind(subject, X, activity)

## Step 9:  Using the data.table library to easily group the tidy data by subject and activity
dataDT <- data.table(data)

## Step 10: Then applied the mean and standard deviation calculations across the groups
tidyData<- dataDT[, lapply(.SD, mean), by=c("subjectId", "activity")]

## Step 11: Write the tidied data to the file "tidy_data.txt"
write.table(tidyData, "tidy_data.txt")