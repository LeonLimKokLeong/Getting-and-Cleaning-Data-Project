######################################################################
######################################################################
## 1. Merges the training and the test sets to create one data set. ##
######################################################################
######################################################################

## Read in the list of 561 features

features <- read.table(".\\UCI HAR Dataset\\features.txt")

## Read in the Features readings from X_*.txt
## Name the columns using the features list

X_test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt", header = TRUE) #if they used some other way of saving the file than a default write.table, this step will be different
colnames(X_test) <- features$V2

X_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt", header = TRUE) #if they used some other way of saving the file than a default write.table, this step will be different
colnames(X_train) <- features$V2

## Read in Action info from Y_*.txt
## Name the column "Activity"

Y_test <- read.table(".\\UCI HAR Dataset\\test\\Y_test.txt", header = TRUE) #if they used some other way of saving the file than a default write.table, this step will be different
colnames(Y_test) <- "Activity"

Y_train <- read.table(".\\UCI HAR Dataset\\train\\Y_train.txt", header = TRUE) #if they used some other way of saving the file than a default write.table, this step will be different
colnames(Y_train) <- "Activity"

## Read in Subject info from subject_*.txt
## Name the column "Subject"

subject_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", header = TRUE) #if they used some other way of saving the file than a default write.table, this step will be different
colnames(subject_test) <- "Subject"

subject_train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", header = TRUE) #if they used some other way of saving the file than a default write.table, this step will be different
colnames(subject_train) <- "Subject"

## Bind TEST data together

test <- cbind(subject_test, Y_test, X_test)

## Bind TRAIN data together

train <- cbind(subject_train, Y_train, X_train)

## Bind TEST and TRAIN data together
## dataset contains the clean data

dataset <- rbind(test, train)


##############################################################################
##############################################################################
## 2. Extracts only the measurements on the mean and standard deviation for ##
## each measurement.                                                        ##
##                                                                          ##
## 4. Appropriately labels the data set with descriptive variable names.    ##
## -  MSdataset, Mean and Standard Deviation dataset                        ##
##############################################################################
##############################################################################

## Column 1 (Subject) and Column 2 (Action) are extracted as default 
## Using Regular Expression, extract column names containing with mean OR std
## Mean_Std_Sdataset contains the Mean and Standard Deviation filtered dataset

Mean_Std_dataset <- dataset[, c( 1, 2, grep("mean|std", names(dataset), ignore.case=TRUE) )]


#################################################################################
#################################################################################
## 3. Uses descriptive activity names to name the activities in the data set.  ##
#################################################################################
#################################################################################

## Read in the name of the activities

activities <- read.table(".\\UCI HAR Dataset\\activity_labels.txt")

## For each V1 values in activities
for ( i in activities$V1)
{
        ## Replace the Action field in MSdataset with the value in activities
        Mean_Std_dataset[Mean_Std_dataset[, "Activity"] == i, 2] <- as.character(activities[i, 2])
}

#################################################################################
#################################################################################
## 5. From the data set in step 4, creates a second, independent tidy data set ##
## with the average of each variable for each activity and each subject.       ##
#################################################################################
#################################################################################

## aggregate Mean_Std_dataset
##           from column 3 onwards
##           by Subject, Activity
##           using mean
Mean_By_Subject_Activity <- aggregate(
                                        Mean_Std_dataset[,3:ncol(Mean_Std_dataset)],
                                        list(Subject = Mean_Std_dataset$Subject, Activity = Mean_Std_dataset$Activity),
                                        mean
                                     )
write.table(Mean_By_Subject_Activity, file = "Mean_By_Subject_Activity.txt", row.name=FALSE)