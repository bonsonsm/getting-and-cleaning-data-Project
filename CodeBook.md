# Code Book

This document describes the code inside `run_analysis.R`.

The code is fully commented and should assist in understanding:

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names.
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Step 1: Merges the training and the test sets to create one data set.

In this step the training and test data were merged. The following files were read and merged:
 1. features.txt
 2. X_train.txt
 3. X_test.txt
 4. Subject_train.txt
 5. Subject_test.txt
 6. y_train.txt
 7. y_test.txt
 8. activtylabels.txt

The activity labels were classified as factors.

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

The data here contains a lot more features / columns than what are required. As we are required to only analysie the mean and standard deviation measurements, the subject, activity and the mean and standard deviation related columns have been extracted.

Along with this it was also seen that certain other columns are in duplicate and so those were also removed.

## Step 3: Uses descriptive activity names to name the activities in the data set
## Step 4: Appropriately labels the data set with descriptive variable names.

Certain column names were not descriptive enough and so the column name were modified like Acc = Accelerometer, Gyro=Gyroscope, Mag=Magnitude, BodyBody = Body.

## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. (In progress)

* Summarizes `meanAndStdData` calculating the average for each column for each activity/subject pair to `meanAndStdAverages`.

## Writing final data to CSV. (To be done)

Creates the output dir if it doesn't exist and writes `meanAndStdAverages` data frame to the ouputfile.
