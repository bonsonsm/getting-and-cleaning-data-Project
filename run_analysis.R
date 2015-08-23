#Steps: You should create one R script called run_analysis.R that does the following. 
#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names. 
#5.From the data set in step 4, creates a second, independent tidy data set 
    #with the average of each variable for each activity and each subject.

run_analysis<-function(){
    library(dplyr)
    library(tidyr)
    
    #Step 1: Merges the training and the test sets to create one data set.
    
    # read items common to training and testing data
    #read the feature
    features = read.table("./features.txt") 
    # reading the activity labels and creating a factor
    activity_labels = read.table("./activity_labels.txt") 
    #read and creat training data set
    x_train = read.table("./train/X_train.txt") 
    #Contains the subject id ranging from 1 to 30
    subject_train = read.table("./train/subject_train.txt") 
    colnames(subject_train) = c("Subject")
    # rename the columns of the x_train data set 
    #with the values in the features
    colnames(x_train)<-features$V2
    y_train = read.table("./train/y_train.txt") 
    # Create factor variable for activity
    activity_type<-factor(y_train$V1, levels=1:6, labels=activity_labels$V2) 
    # merging subject, activity and data
    merged_data_train<-cbind(subject_train,activity_type,x_train)
    ##########################test data####################
    #read and create test data set
    x_test = read.table("./test/X_test.txt") 
    #Contains the subject id ranging from 1 to 30
    subject_test = read.table("./test/subject_test.txt") 
    colnames(subject_test) = c("Subject")
    # rename the columns of the x_test data set 
    #with the values in the features
    colnames(x_test)<-features$V2
    y_test = read.table("./test/y_test.txt") 
    # Create factor variable for activity
    activity_type<-factor(y_test$V1, levels=1:6, labels=activity_labels$V2) 
    # merging subject, activity and data
    merged_data_test<-cbind(subject_test,activity_type,x_test)
    ################### merge test and training data #####################
    merged_data<-rbind(merged_data_train, merged_data_test)
    print(nrow(merged_data))
    #Step 1 Completed
    
    ##Step 2
    #2.Extracts only the measurements on the mean and standard deviation for each measurement. 
    
    #certain columns are dulicated and so need to be removed Example: fBodyAcc-bandsEnergy()-1,8
    merged_data <- merged_data[ , !duplicated(colnames(merged_data))]
    
    #extract subjet, activity_type, all the columns that contain mean or std
    
    #Per the features_info.txt file, there were 33 main variables measured. 
    #For each variable, a number of statistics were calculated, 
    #including a mean and standard deviation. 33 * 2 = 66 means and standard deviations.
    #Other variables have the term "mean" in them (such as meanFreq), 
    #but they have a different meaning than a simple mean on a single variable. 
    
    mean_std_data <- select(.data = merged_data, Subject, activity_type,
                           contains("mean("), contains("std("))
    
    ##Step 3 and 4
    #3.Uses descriptive activity names to name the activities in the data set
    #4.Appropriately labels the data set with descriptive variable names.
    
    # Change the following terms to full forms - Acc, Gyro, Mag
    # Convert BodyBody to Body
    
    names(mean_std_data) <- gsub("Acc", "Accelerometer", names(mean_std_data))
    names(mean_std_data) <- gsub("Gyro", "Gyroscope", names(mean_std_data))
    names(mean_std_data) <- gsub("Mag", "Magnitude", names(mean_std_data))
    names(mean_std_data) <- gsub("BodyBody", "Body", names(mean_std_data))
    #print(colnames(mean_std_data))
    
    #Writing the data to a file
    write.table(mean_std_data, "./tidydata.txt", row.name=FALSE) 
    
}