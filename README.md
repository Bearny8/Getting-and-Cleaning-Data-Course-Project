# Getting-and-Cleaning-Data-Course-Project
Peer-graded Assignment: Getting and Cleaning Data Course Project


I added an Excel file 'final_activity_subject.xlsx' - export of the final result


I also calculated averages for every activity and every subject - these are optional:

final_activity<-aggregate(newtap[,4:79], list(newtap$Activity),mean)
final_subject<-aggregate(newtap[,4:79], list(newtap$Subject),mean)
