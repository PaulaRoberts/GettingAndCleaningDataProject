
# This run_analysis.R file runs with the project data set in the 
# current working directory as per the Assignment instructions.


# 1: MERGE THE TRAINING AND TEST SETS TO CREATE ONE DATA SET

subject_testDF <- read.table("./test/subject_test.txt", header = FALSE)
y_testDF <- read.table("./test/y_test.txt", header = FALSE)
x_testDF <- read.table("./test/X_test.txt", header = FALSE)

testDF <- cbind(subject_testDF, y_testDF, x_testDF)

subject_trainDF <- read.table("./train/subject_train.txt", header = FALSE)
y_trainDF <- read.table("./train/y_train.txt", header = FALSE)
x_trainDF <- read.table("./train/X_train.txt", header = FALSE)

trainDF <- cbind(subject_trainDF, y_trainDF, x_trainDF)

completeDF <- rbind(testDF, trainDF)


#  2: EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR 
#     EACH MEASUREMENT (using dplyr)

install.packages("dplyr")
library(dplyr)

featuresDF <- read.table("features.txt", header = FALSE, stringsAsFactors=F)

colnames(completeDF)[3:563] <- featuresDF[,2]

selectDF <- select(completeDF, contains("mean()"), contains("std()"), 
                       -contains("meanFreq()"), -contains("angle"),
                       -contains("gravityMean"))

meanAndStdDF <- cbind(completeDF[,c(1:2)], selectDF)


# 3: USE DESCRIPTIVE ACTIVITY LABELS TO NAME THE ACTIVITIES IN THE DATA SET

activity_vector <- c('1' = 'WALKING', 
                     '2' = 'WALKING_UPSTAIRS', 
                     '3' = 'WALKING_DOWNSTAIRS', 
                     '4' = 'SITTING', 
                     '5' = 'LAYING')

vectorised_activity <- activity_vector[meanAndStdDF[,2]]
meanAndStdDF[,2] <- vectorised_activity


# 4: APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES

names(meanAndStdDF)[1] <- ("Subject_ID")

names(meanAndStdDF)[2] <- ("Activity")

# Eliminate all brackets, (), from the variable names

names(meanAndStdDF) <- gsub("\\(|\\)", "", names(meanAndStdDF))

# Replace all '-X', '-Y' and '-Z' with the more meaningful 'on X axis'

names(meanAndStdDF) <- gsub("-X", " on X-axis", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("-Y", " on Y-axis", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("-Z", " on Z-axis", names(meanAndStdDF))

# Replace given names with more meaningful ones

names(meanAndStdDF) <- gsub("tBodyAcc-mean", "Mean Acceleration of Subject", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tGravityAcc-mean", "Mean Gravity Acceleration", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tBodyAccJerk-mean", "Mean Linear Jerk of Subject", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tBodyGyro-mean", "Mean Gyroscopic Acceleration of Subject", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tBodyGyroJerk-mean", "Mean Angular Jerk of Subject", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tBodyAccMag-mean", "Mean Acceleration of Subject on 3 axes", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tGravityAccMag-mean", "Mean Gravity Acceleration of Subject on 3 axes", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tBodyAccJerkMag-mean", "Mean Linear Jerk of Subject on 3 axes", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tBodyGyroMag-mean", "Mean Gyroscopic Acceleration of Subject on 3 axes", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tBodyGyroJerkMag-mean", "Mean Angular Jerk of Subject on 3 axes", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("fBodyAcc-mean", "Mean Acceleration of Subject using FFT", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("fBodyAccJerk-mean", "Mean Linear Jerk of Subject using FFT", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("fBodyGyro-mean", "Mean Gyroscopic Acceleration of Subject using FFT", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("fBodyAccMag-mean", "Mean Acceleration of Subject on 3 axes using FFT", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("fBodyBodyAccJerkMag-mean", "Mean Linear Jerk of Subject on 3 axes using FFT", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("fBodyBodyGyroMag-mean", "Mean Gyroscopic Acceleration of Subject on 3 axes using FFT", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("fBodyBodyGyroJerkMag-mean", "Mean Angular Jerk of Subject on 3 axes using FFT", names(meanAndStdDF))

names(meanAndStdDF) <- gsub("tBodyAcc-std", "Standard Deviation of Acceleration of Subject", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tGravityAcc-std", "Standard Deviation of Gravity Acceleration", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tBodyAccJerk-std", "Standard Deviation of Linear Jerk of Subject", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tBodyGyro-std", "Standard Deviation of Gyroscopic Acceleration of Subject", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tBodyGyroJerk-std", "Standard Deviation of Angular Jerk of Subject", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tBodyAccMag-std", "Standard Deviation of Acceleration of Subject on 3 axes", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tGravityAccMag-std", "Standard Deviation of Gravity Acceleration of Subject on 3 axes", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tBodyAccJerkMag-std", "Standard Deviation of Linear Jerk of Subject on 3 axes", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tBodyGyroMag-std", "Standard Deviation of Gyroscopic Acceleration of Subject on 3 axes", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("tBodyGyroJerkMag-std", "Standard Deviation of Angular Jerk of Subject on 3 axes", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("fBodyAcc-std", "Standard Deviation of Acceleration of Subject using FFT", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("fBodyAccJerk-std", "Standard Deviation of Linear Jerk of Subject using FFT", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("fBodyGyro-std", "Standard Deviation of Gyroscopic Acceleration of Subject using FFT", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("fBodyAccMag-std", "Standard Deviation of Acceleration of Subject on 3 axes using FFT", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("fBodyBodyAccJerkMag-std", "Standard Deviation of Linear Jerk of Subject on 3 axes using FFT", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("fBodyBodyGyroMag-std", "Standard Deviation of Gyroscopic Acceleration of Subject on 3 axes using FFT", names(meanAndStdDF))
names(meanAndStdDF) <- gsub("fBodyBodyGyroJerkMag-std", "Standard Deviation of Angular Jerk of Subject on 3 axes using FFT", names(meanAndStdDF))


# 5: CREATE A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH
#    VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT (using reshape2)

install.packages("reshape2")
library(reshape2)

meltDF <- melt(meanAndStdDF, id.vars=c("Subject_ID", "Activity"))

tidyDF <- dcast(meltDF, Subject_ID + Activity ~ variable, 
                 value.var = "value", 
                 fun.aggregate = mean, na.rm = TRUE)


