## Get dplyr ready
library(dplyr)

##set test directory
setwd("~/UCI HAR Dataset/test")

##read test files
x_test<-read.table("X_test.txt")
y_test<-read.table("y_test.txt")
subject_test<-read.table("subject_test.txt")

## set training directory
setwd("~/UCI HAR Dataset/train")

##read training files
x_train<-read.table("X_train.txt")
y_train<-read.table("y_train.txt")
subject_train<-read.table("subject_train.txt")


##Merges the training and the test sets to create one data set
total_x<-rbind(x_test,x_train)
total_y<-rbind(y_test,y_train)
total_subject<-rbind(subject_test,subject_train)

##Extracts only the measurements on the mean
##and standard deviation for each measurement.

##set features directory
setwd("~/UCI HAR Dataset")

##read features file
feat<-read.table("features.txt")

##reformating as character
feat$V2<-as.character(feat$V2)

## getting only statndar deviation and mean measures
found<-feat[grepl("std|mean",feat$V2),1]

##Uses descriptive activity names to name the activities in the data set.
found_x<-total_x[,found]
namesfeat<-feat[found,2]
newfound_x<-rbind(namesfeat,found_x)

##Appropriately labels the data set with descriptive variable names

##reading labels 
act <- read.table("activity_labels.txt")

##moving on
act[total_y[,1],2]
total_y[,1]<-act[total_y[,1],2]

## Naming columns
names(total_y)<-"Activity"
names(total_subject)<-"Subject"

## merging everything togather
total_x_y_subject<-cbind(total_x,total_y,total_subject)

##From the data set in step 4, creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject.
newt<- select(total_x_y_subject,Activity, Subject, V1:V561)
newtap<-mutate(newta, unique_set = paste(Activity,"/",Subject))
newtap<-select(newtap,Activity,Subject,unique_set, V1:V561)

##Avergages for all varuables by activity and subject combinatiod
final_activity_subject<-aggregate(newtap[,4:564], list(newtap$unique_set),mean)

##Avergages for all varuables by activity 
final_activity<-aggregate(newtap[,4:564], list(newtap$Activity),mean)

##Avergages for all varuables by subject
final_subject<-aggregate(newtap[,4:564], list(newtap$Subject),mean)

##saving results in Excel
write.xlsx(final_activity_subject,"final_activity_subject.xlsx")
write.xlsx(final_activity,"final_activity.xlsx")
write.xlsx(final_subject,"final_subject.xlsx")
