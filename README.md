#Getting-and-Cleaning-Data-Project


##Files used by the script

* activity_labels.txt

List of all 6 activities identifier and the activity name.

* features.txt

List of all 561 features recorded for each window sample.

* test/subject_test.txt
* train/subject_train.txt

Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

* test/Y_test.txt
* train/Y_train.txt

Each row contains the activity perform by the subject, The acivity is recorded as a number coressponding to the activities identifier in activity_lables.txt

* test/X_test.txt
* train/X_train.txt

Each row contains the 561 features recorded for each of the activity by subjects.


##Data cleaning

###1. Merges the training and the test sets to create one data set.

Read in all the X_* files and label the columns with the names in features.txt.
Read in all the Y_* files and label the column "Activity"
Read in all the subject_* files and label the column "Subject"

The X Y and subject files in the respective test and the train are cbind together to create the test and train dataset.

The test and train dataset are then rbind together to create one dataset.


###2. Extracts only the measurements on the mean and standard deviation for each measurement.                                                        

Using regular expression, only mean() and std() of the 561 feature records are selected into a new dataset instead of overwriting the dataset created in 1.

This allows the users to compare and verify that there are no missing extraction.


###3. Uses descriptive activity names to name the activities in the data set.

With reference to activity_labels.txt, the 6 activity identifier in column Activity are replace with the activity names.


###4. Appropriately labels the data set with descriptive variable names.

Removing the brackets "()"" in the column labels.


###5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Column 1 contains the Subject, column 2 contains the Activity.
The datas are aggregated by the Subject and Activity, and column 3 onwards are average off using mean.


###6. Write the filtered and aggregated data into a text file.

write.table(Mean_By_Subject_Activity, file = "DataSet_mean_by_subject_activity.txt", row.name=FALSE)