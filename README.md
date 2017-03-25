# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1.  Download and unzip the dataset
2.  Loaded test and training data sets into data frames
3.  Loaded source variable names for test and training data sets
4.  Loaded activity labels
5.  Combined test and training data frames using rbind
6.  Paired down the data frames to only include the mean and standard deviation variables
7.  Replaced activity IDs with the activity labels for readability
8.  Combined the data frames to produce one data frame containing the subjects, measurements and activities
9.  Using the data.table library to easily group the tidy data by subject and activity
10. Then applied the mean and standard deviation calculations across the groups
11. Write the tidied data to the file "tidy_data.txt"

The end result is shown in the file "tidy_data.txt".

The script is developed under the following environment.
1.  Windows 7 Enterprise
2.  R 3.3.2
3.  RStudio 1.0.136

To run the run_analysis.R, please follow the steps below.
1.  Checkout the code using 'git checkout https://github.com/ngyikhon/GettingAndCleaningDataCourseProject.git YOURDIRECTORY' or download and extract the github respository.
2.  Load RStudio and set your working directory using setwd("YOURDIRECTORY")
3.  Execute the run_analysis.R script.
4.  The output tidy_data.txt is generated after the code is run successfully.