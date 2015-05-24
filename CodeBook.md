# Getting and Cleaning Data Course Project

Daniel Ielpo

## Description
This file contains informations that describes the variables, the data, and the transformations or works performed to clean up the data used in the Course Project for the Johns Hopkins Getting and Cleaning Data Course.

## Source Data
A full description is available at the site where the data was obtained:[The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The data used in this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: [Web Link](http://www.youtube.com/watch?v=XOEN9W05_4A)

## Attribute Information
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

## Step 0. Setup the environment
In this code session all libraries needed to run 'run_analysis.R' are loaded.
The script creates a subfolder './data' in the working directory to save the data downloaded for the previous data set link.
It downloads the data and unzip it to 'data' folder and creates a variable containing the directory path to the 'UCI HAR Dataset'.

## Step 1. Merge the training and the test sets to create one data set.
After the setup the training and the test files are read into data frames:

- x_train.txt
- x_test.txt
- y_train.txt
- y_test.txt
- subject_train.txt
- subject_test.txt

Then all test and train data frames are merged by rows, and the column names of the data frames are assigned.

The three data frames are column binded.

## Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
Searchs for the column names containing "mean" and "std, and then subset the data to keep only the columns with this two measures.

## Step 3. Uses descriptive activity names to name the activities in the data se
Read the activity labels file and then merge the data with the corresponding activity label.

## Step 4. Appropriately labels the data set with descriptive variable names.
The data frame labels are renamed using a pattern:

- "()" - are removed
- "^t" - is renamed to "time"
- "^f" - is renamed to "frequency"
- "-std" - is renamed to "StdDev"
- "-mean" - is renamed to "Mean"
- "Acc" - is renamed to "Accelerometer"
- "Gyro" - is renamed to "Gyroscope"
- "Mag" - is renamed to "Magnitude"
- "BodyBody" - is renamed to "Body"

## Step 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
Creates an independent data set with the average of each variable aggregated by subjet and the activity name.

The data table is exported to the file "tidydata.txt"