## Subject and Activity
These variables identify the unique subject/activity pair the variables relate to:
 - Subject: the integer subject ID.
 - Activity: the string activity name:
  - Walking
  - Walking Upstairs
  - Walking Downstairs
  - Sitting
  - Standing
  - Laying

## About Measurement Means
All variables are the mean of a measurement for each subject and activity. This is indicated by the initial Mean in the variable name.

## About R script --"run_analysis.R" perform the following steps
•	Download source data 
•	Unzip the datasets
•	Reading activity label 
•	Reading feature vector
•	Extract only the data on mean and standard deviation
•	Reading training tables
•	Reading testing tables
•	Merge dataset and add labels
•	Turn activities & subjects into factors

## About variables:   
* 'x_train', 'y_train', 'x_test', 'y_test', 'subject_train' and 'subject_test' contain the data from the downloaded files.
