#
# Coursera 
# Johns Hopkins Data Specialization
# Course 3 Getting and Cleaning Data 
# Course Project
# JPR
#
# 1. Merges the training and the test sets to create one data set. 
# 2. Extracts only the measurements on the mean and standard deviation 
#      for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set
#      with the average of each variable for each activity and each subject.
# The script does them in this order. 
#
# Download the zip
# Unzip the zip 
# Read Data into tables 
# Merge the data
#   1. Megre test sets to create one data set, rbind() and cbind()
# Work with smaller data
#   2.Select only mean and std dev column select
# Apply decriptive activity names to y
#   3. Uses descriptive activity names
# Apply descriptive names to coulmns
#   4. labels the data set with descriptive variable names
library('gdata')
library('plyr')

# File names

fnsource<-'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
fnlocal<-'getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
fnoutput<-'./project.tidy.output.txt'

# OPTIONAL Zip Download. only works if you have internet access
# other wise - unzip to the working folder
#download.file(fnsource,fnlocal)  # only works if you have internet access 
#unzip (fnlocal, exdir = ".")

# Assumption - 
# Dataset Root folder: UCI HAR Datase is in directory with run_analysis.R and it is working directory. 

# Actviity_label  V1 is the number, V2 is the name  goes to y_values
activity_labels<-read.table('./UCI HAR Dataset/activity_labels.txt')
dim(activity_labels)   # 6 2
activity_labels$V2<-as.character(activity_labels$V2)
anuml<-as.list(activity_labels$V1)
anamel<-as.list(activity_labels$V2)

# Feature_list gives me V1 column number and V2  column name
feature_list<-subject_train<-read.table('./UCI HAR Dataset/features.txt')
feat_col_nums<-grep(('mean[^F]|std'),feature_list$V2)
feat_col_names<-grep(('mean[^F]|std'),feature_list$V2, value=TRUE)

# scrub the names the '-' char causes problems for some ops
feat_col_names_new<-gsub('-','_',feat_col_names)
feat_col_names_new<-gsub('[()]','',feat_col_names_new)


X_train<-read.table('./UCI HAR Dataset/train/X_train.txt')
dim(X_train)  #  7352    561
X_test<-read.table('./UCI HAR Dataset/test/X_test.txt')
dim(X_test)   #  2947   561

df_X<-rbind(X_train, X_test)

df_X<-df_X[,feat_col_nums]  # reduce the data size
names(df_X)<-feat_col_names_new
dim(df_X)                   # 10299   66


y_train<-read.table('./UCI HAR Dataset/train/y_train.txt')
dim(y_train)   # 7352    1
y_test<-read.table('./UCI HAR Dataset/test/y_test.txt')
dim(y_test)    # 2947    1

df_y<-rbind(y_train, y_test)

df_y$V1<-unlist(mapvalues(df_y$V1, from=anuml, to=anamel))
names(df_y)<-c('activity')
dim(df_y)     #  10299    1


subject_train<-read.table('./UCI HAR Dataset/train/subject_train.txt')
dim(subject_train)  # 7352    1
subject_test<-read.table('./UCI HAR Dataset/test/subject_test.txt')
dim(subject_test)   # 2947    1

df_subject<-rbind(subject_train, subject_test)

names(df_subject)<-c('subject')

# Combine df Columns
df_all<-cbind(df_X,df_y,df_subject)
dim(df_all)  # 10299   68


## do the assessment ##################
# Subject them Activity
#df_final<- aggregate( . ~ subject+activity, data = df_all, mean)

# Activity then Subject
df_final<- aggregate( . ~ activity+subject, data = df_all, mean)

# Required Output
write.table(df_final, file=fnoutput, row.name=FALSE )

# for documentation
onl<-names(df_final)
write.table(onl,file='./finalnames.txt')


# Example Only df_final supports further analysis 
#xtabby<-xtabs(fBodyBodyGyroMag_mean ~activity+subject, data=df_final)
#print(xtabby)
xtabby<-xtabs(fBodyBodyGyroMag_mean ~subject+activity, data=df_final)
print(xtabby)

# Example Read back
df_processed<-read.table(fnoutput)
print(df_processed)

# END


