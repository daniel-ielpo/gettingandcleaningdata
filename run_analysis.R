#You should create one R script called run_analysis.R that does the following. 

#1 - Merges the training and the test sets to create one data set.
#2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
#3 - Uses descriptive activity names to name the activities in the data set
#4 - Appropriately labels the data set with descriptive variable names. 
#5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#################################################################
# Step 0
# Setup the environment
#################################################################

# Loads all the necessary libraries
library(dplyr)

# Downloads the data set files
if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="auto")

# Extracts the dataset files
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Creates a path variable for the UCI HAR Dataset unzipped folder
dataPath <- file.path("./data", "UCI HAR Dataset")

#################################################################
# Step 1
# Merges the training and the test sets to create one data set.
#################################################################

# Read the test and train files
activityTest  <- read.table(file.path(dataPath, "test" , "Y_test.txt" ),header = FALSE)
activityTrain <- read.table(file.path(dataPath, "train", "Y_train.txt"),header = FALSE)

subjectTrain <- read.table(file.path(dataPath, "train", "subject_train.txt"),header = FALSE)
subjectTest  <- read.table(file.path(dataPath, "test" , "subject_test.txt"),header = FALSE)

featuresTest  <- read.table(file.path(dataPath, "test" , "X_test.txt" ),header = FALSE)
featuresTrain <- read.table(file.path(dataPath, "train", "X_train.txt"),header = FALSE)

# Merge the data training and test data frames by rows
activity<- rbind(activityTrain, activityTest)
subject <- rbind(subjectTrain, subjectTest)
features<- rbind(featuresTrain, featuresTest)

# Set the names of the variables
names(subject)<-c("subject")
names(activity)<- c("activity")

# Read the features file that contains the features names and set the features column names
featuresNames <- read.table(file.path(dataPath, "features.txt"),head=FALSE)
names(features)<- featuresNames$V2

# Merge all data columns into one data frame
allData <- cbind(features, subject, activity)

#################################################################
# Step 2
# Extracts only the measurements on the mean and standard deviation for each measurement. 
#################################################################

# Search for columns with mean or std in their names
meanStdFeaturesNames<-featuresNames$V2[grep("mean\\(\\)|std\\(\\)", featuresNames$V2)]

# Subset the data frame Data by seleted names of Features
subsetNames<-c(as.character(meanStdFeaturesNames), "subject", "activity" )
allData<-subset(allData,select=subsetNames)

#################################################################
# Step 3
# Uses descriptive activity names to name the activities in the data set
#################################################################

# Read the activity labels file
activityLabels<-read.table(file.path(dataPath, "activity_labels.txt"),header = FALSE)

names(activityLabels)<-c("activity","activityName")

# Merge the activity labels with the all data
allData<-merge(allData,activityLabels,by="activity",all.x=TRUE)

#################################################################
# Step 4
# Appropriately labels the data set with descriptive variable names. 
#################################################################

names(allData)<-gsub("\\()","",names(allData))
names(allData)<-gsub("^t", "time", names(allData))
names(allData)<-gsub("^f", "frequency", names(allData))
names(allData)<-gsub("-std$","StdDev",names(allData))
names(allData)<-gsub("-mean","Mean",names(allData))
names(allData)<-gsub("Acc", "Accelerometer", names(allData))
names(allData)<-gsub("Gyro", "Gyroscope", names(allData))
names(allData)<-gsub("Mag", "Magnitude", names(allData))
names(allData)<-gsub("BodyBody", "Body", names(allData))

#################################################################
# Step 5
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#################################################################

# Removes the activity index column
allData<-allData[,names(allData) != "activity"]

# Creates an independent data set with the average of each variable
tidyData<-aggregate(. ~subject + activityName, allData, FUN=mean)
tidyData<-tidyData[order(tidyData$subject,tidyData$activityName),]
write.table(tidyData, file = "tidydata.txt",row.name=FALSE)
