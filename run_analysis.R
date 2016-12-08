#David Lennox-Hvenekilde
library(dplyr)
library(tidyr)

#Downloading extracting and reading data files
if(!file.exists("./zipfile")){dir.create("./zipfile")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./zipfile/samsung.zip")
unzip("./zipfile/samsung.zip")

#Read training and test data sets:
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test<- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train<- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

#Read features and activitylabels
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Assing the variable names from features to the X_train and X_test
names(X_train) <- features$V2
names(X_test) <- features$V2

#Choosing only the variables/columns containg measurement on means and standard deviations
X_train <- X_train[,grep("mean()|std()", names(X_train))]
X_test <- X_test[,grep("mean()|std()", names(X_test))]

#assigning activity to observations in test and train, based on key in activity_labels
y_test <- mutate(y_test, V1 = activity_labels[V1,2])
y_train <- mutate(y_train, V1 = activity_labels[V1,2])

#Giving the remaining variabls/columns correct names
names(y_test) <- "activity"
names(y_train) <- "activity"
names(subject_train) <- "subject"
names(subject_test) <- "subject"

#How we combine all three, two create two complete dataset, one for train and for test
train <- data.frame(c(subject_train, y_train, X_train))
test <- data.frame(c(subject_test, y_test, X_test))

#the test and train set are combined in one
all_data <- tbl_df(rbind(test,train))
#fixing the column names:
names(all_data)<-gsub("\\.\\.\\.","\\.",names(all_data))

#We now group the data by subject and activity with the dplyr package
#Then we summarise all the rows, in the subject/activity groups
all_data_grouped <- group_by(all_data, subject, activity)
Sum_all_data_means <- summarise_each(all_data_grouped, funs(mean))

#Sum_all_data_means now contains all the relevant data summed by the means
#of the subject and activity groups

#Output file:
write.table(Sum_all_data_means, "./Sum_all_data_means.txt")


