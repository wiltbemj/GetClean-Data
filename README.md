# GetClean-Data
Repository for the Coursea Getting and Cleaning Data Class

## Files in this repository
This repository contains 5 files

1. README.md - this file
2. CodeBook.Rmd - R Markdown file describing the tidy data set and the process for creating it
3. CodeBook.html - HTML version of the Codebook produced the R Markdown file
4. run_analysis.R - Code that converts UCI data set into the tidy data set
5. activity-tidy.txt - the tidy data set

## Details of the run_analysis.R code
This code uses the capabilities of the dplyr package to accomplish most of the required tasks for cleaning the data.  The code uses read.table to load the X, y, and subject data files from the test and train subdirectories.  The labels for the activities and measurements are obtained from the activity_labels.txt and features.txt files in the main directory.

After the files are loaded the cbind function is used to combine the X, Y, subject data into a single dataframe for the test and train data sets.  The rbind function combines the test and train data sets into a single dataframe.  The names for the columns in the dataframe are set with information loaded from the features.txt file along with ActivityType and Subject for the last two columns. Using the select function from dpylr library only the mean and std measurements along with ActivityType and Subject are selected.  The ActivityType integers are then replaced with the labels loaded from the activity_labels.txt file using the mutate capability of the dplyr library.  

Now that we have a dataframe with the desired quantities we can proceed with reducing the data set.  Using the group_by function of the dplyr library the data set is first grouped by activity type and then by subject.  For each of these observations the summerise_each function is used to compute the mean of the observations.  The write.table function with row.names=FALSE is used to produce the tidy data set file called activity-tidy.txt in the current working directory.
