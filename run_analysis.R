## This code will prcoeess the UCI Smartphone dataset into a tidy data set. 
## It acomplishes this in N steps.  The first step is to combine the test and training data set.
## The next step is to select the mean and standard deviation for each measurement.  We then use the
## labels for the activites from the descriptions provided by UCI.  The penultimate step is to give
## the measurements meaningful names.  Finally a tidy data set of mean of each actvitiy and subject
## is ouptput to the activity-tidy.txt file.

## NB - This function must be run from the directory containing the UCI HAR Dataset directoy
library(dplyr)

run_analysis <- function() {
  
  #First read in the Activity Labels and Feature Names that are shared across the test/train data sets
  activityLabel <- read.table('activity_labels.txt')
  measLabel <- read.table('features.txt')
  
  #Then read in the Test data set
  Xtest <- read.table('test/X_test.txt')
  Ytest <- read.table('test/Y_test.txt')
  Stest <- read.table('test/subject_test.txt')

  #Now read in the training data set
  Xtrain <- read.table('train/X_train.txt')
  Ytrain <- read.table('train/y_train.txt')
  Strain <- read.table('train/subject_train.txt')
  
  #combine the Measurements, Activity and Subject into one dataframe and add a label
  fulltest <- cbind(Xtest,Ytest,Stest)
  fulltrain <- cbind(Xtrain,Ytrain,Strain)
  full <- rbind(fulltest,fulltrain)
  colnames(full) <- make.names(c(as.vector(measLabel$V2),'ActivityType','Subject'),
                                   unique=TRUE, allow_ = TRUE)
  #now pull out just the average, standard deviation, ActivityType, and subject columns
  meanStd <- select(full,contains('mean'),contains('std'),starts_with('Act'),
                        starts_with('Subj'))
  meanStd <- mutate(meanStd,ActivityType=as.vector(activityLabel$V2)[ActivityType])
  #then group and summarize each by the mean
  meanStdGrouped <- group_by(meanStd,ActivityType,Subject)
  summary <- summarise_each(meanStdGrouped,funs(mean))
  # and finally write the tidy data set to a file
  write.table(summary,file='activity-tidy.txt',row.names=TRUE)


}