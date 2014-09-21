
This is the README markdown file to accompany the Coursera Getting and Cleaning Data Project. This project involved manipulating the given data
sets as follows:

1: Merge the training and the test sets to create one data set.
2: Extract only the measurements on the mean and standard deviation for each measurement. 
3: Use descriptive actvity names to name the activities in the data set
4: Appropriately labels the data set with descriptive variable names. 
5: From the data set derived, create a second, independent tidy data set with the average of each variable for each activity and each subject.

The data set provided is extracted into the current working directory
and from there the run_analysis.R script carries out the required steps. Details of each step is as follows:


1: MERGE THE TRAINING AND TEST SETS TO CREATE ONE DATA SET

Read in the test data sets from the given text files.
Each text file is first read into a separate dataframe.
The dataframes for the test data are then assembled into one dataframe (testDF) such that the subject_test column is first, the y_test column second and the measurements from the x_test table the remaining 561 columns.

Read in the training data sets from the given text files
Each text file is first read into a separate dataframe
The dataframes for the test data are then assembled into one dataframe (trainDF) such that the subject_test column is first, the y_test column second and the measurements from the x_test table the remaining 561 columns.

The 2 dataframes are then combined to create one dataframe, completeDF, such that the test data set occupies the first 2947 rows and the training data set occupies the following 7352 rows.


2: EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT 

The features.txt file lists the measurements recorded. According to the information given in the features_info file, the mean and standard deviation data is identified in the variables by 'mean()' and 'std()'. 

I have used the dplyr package here as it "provides a set of tools for efficiently manipulating datasets in R" [blog.rstudio.org/2014/01/17/introducing-dplyr/, Accessed 18/9/14]

Read the full list of features describing each measurement taken from the given features text file. I use the stringsAsFactors option here to allow me to use the features listed as character data types rather than factors.

The second row of this dataframe is a character vector containing the names of the measurements. I use the colnames function to apply this vector across the relevent columns of the data set. Note that the first two columns refer to subject_data and y_data and so are skipped over here. 

The dplyr package can now be used to extract the names containing 'mean' and 'std'. Note that some variables have names containing these strings but they do not contain the specific values requested, specifically the meanFreq(), angle() and gravityMean() values. These are not selected.

The first two columns can now be added back in to result in a data set which contains the subject_data, the y_data along with the mean and standard deviation measurements.


3: USE DESCRIPTIVE ACTIVITY LABELS TO NAME THE ACTIVITIES IN THE DATA SET

The activity_labels text file numbers the recorded activites as follows:
 1 WALKING
 2 WALKING_UPSTAIRS
 3 WALKING_DOWNSTAIRS
 4 SITTING
 5 STANDING
 6 LAYING
These activites are recorded in the y_data which is the second column in the completeDF data frame. This is currently a column of type int reflecting each activity by its number. In order to translate these numbers into the relevent activity, I created an activity vector.

I then used vectorisation to replace the elements accordingly and substituted the result back into the data frame.


4: APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES

As the steps are numbered, I am assuming that the data set in question here is the one produced in previous steps, meanAndStdDF.The first column in this data set consists of data from the subject_data files identifying the subject in question. An appropriate label would therefore be Subject_ID. 

The second column consists of data from the y_data files identifying the particular activity in question. An appropriate label would therefore be Activity. 

The remaining columns consist of data from the x_data files recording the mean and standard deviation measurements taken. The column names have been taken directly from the features text file. Some of the labels given in this file are not very meaningful. 


5: CREATE A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT

I used the reshape2 package to tidy the data.
The melt function allows for a long data set to be created the then the dcast method is used to take the average of each measurement for each Subject_ID and Activity. Therefore a tidy data set is created which adheres to the principles of tidy data with one variable per column and one observation per row (http://vita.had.co.nz/papers/tidy-data.pdf)