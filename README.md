==================================================================
Original Data Set

	Human Activity Recognition Using Smartphones Dataset
	Version 1.0

	Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
	Smartlab - Non Linear Complex Systems Laboratory
	DITEN - Università degli Studi di Genova.
	Via Opera Pia 11A, I-16145, Genoa, Italy.
	activityrecognition@smartlab.ws
	www.smartlab.ws
	For more information about this dataset contact: activityrecognition@smartlab.ws
	License info at the end of this file. 
	
==================================================================
Course 
	Coursera 
	Johns Hopkins Data Specialization
	Course 3 Getting and Cleaning Data 

Project Info
	Course Project 
	JPR  April 2018

Requirement
	1. Merges the training and the test sets to create one data set. 
	2. Extracts only the measurements on the 'mean' and 'standard deviation' for each measurement.
	3. Uses descriptive activity names to name the activities in the data set
	4. Appropriately labels the data set with descriptive variable names.
	5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Additional Reuqirement
	Upload your data set as a txt file created with write.table() using row.name=FALSE
	
	Submit a link to a Github repo with the project package.  Project Pacakge includes:
		run_analysis.R:	The code should have a file run_analysis.R in the main directory that can be run as long as the data set is in your working directory. 
		coursera.jh.r.data.spec.3.gather.course.project.tidy.output.txt:	The output should be the tidy data set you submitted for part 1. 
		README.md	in the repo describing how the script works
		CodeBook.txt:	describing the variables

=========================================
The project uses the following files from the original dataset:
=========================================
- 'features.txt': List of all features.  It is the COLUMN NAMES and COLUMN NUMBERS.   
- 'activity_labels.txt': Links the class labels with their activity name   

- 'train/X_train.txt': Training set.   
- 'train/y_train.txt': Training labels.  Class Labels.  It is an activity number.  Will be replaced with Activity Name.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.  

- 'test/X_test.txt': Test set.         
- 'test/y_test.txt': Test labels.   Class Labels.  It is an activity number.  Will be replaced with Activity Name.   
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.    

Dimensions
- 'activity_labels.txt':	dim(6,2)
- 'features.txt':	dim(561,2)

- 'train/X_train.txt':	dim(7352, 561)
- 'train/y_train.txt':	dim(7352, 1)
- 'train/subject_train.txt':	dim(7352, 1)

- 'test/X_test.txt':	dim(2947,561) 
- 'test/y_test.txt':	dim(2947,1)
- 'test/subject_test.txt':	dim(2947, 1)


=========================================
run_analysis.R          Sequence
=========================================
Optional: Download the zip
Optional; Unzip the zip 

Now Assume that the zip file is unzipped in the directory where the run_analysis.R resides.
Assume the directory UCI HAR Dataset is in the same directory as run_analysis.R

Note: With this approach there are two implementation options.  
	Read, combine, clean, combine. 
	Read, clean, combine: 
	I did it both ways. Difference is:
		Read, combine, clean, combine:	read, 3 rbinds, 3 cleans, then 1 cbind.  
		Read, clean, combine:   		read, 6 cleans, 2 cbinds, then 1 rbind.  This Option is presented. 


Read Data into tables 
- 'activity_labels.txt'
	get the labels, get a list of the numbers and the names
	
- 'features.txt':	dim(561,2)
	scrub the names to remove '-' and '()' so they can be referenced in the normal way	Req: 4. labels the data set with descriptive variable names
	select names containing 'mean' and 'std',  NOT 'meanFreq'	Req:   2.Select only mean and std dev column select
	get a list of the feature numbers and feature names
	
- 'train/X_train.txt':	dim(7352, 561)
	Get X_train data
	Select only required columns	dim(7352, 66)
	Name the columns	Req: 4. labels the data set with descriptive variable names
	
- 'train/y_train.txt':	dim(7352, 1)
	Convert class numbers to class names	Req: 3. Uses descriptive activity names
	Name the column 'activity'   

- 'train/subject_train.txt	dim(7352, 1)
	Name the column 'subject'


cbind the train data	Req:   1. Combine test sets to create one data set, rbind() and cbind()
	

Same as for test data	
- 'test/X_test.txt':	dim(2947,561) 
	Get test data
	Select only required columns	dim(2947,66) 
	Name the columns	Req: 4. labels the data set with descriptive variable names
	
- 'test/y_test.txt':	dim(2947, 1)
	Convert class numbers to class names	  Req: 3. Uses descriptive activity names
	Name the column 'activity'
	
- 'test/subject_test.txt':	dim(2947, 1)
	Name the column 'subject'

cbind the test data	Req:   1. Combine test sets to create one data set, rbind() and cbind()
	
rbind train and test data to all data	Req:   1. Combine test sets to create one data set, rbind() and cbind()
	
Aggregate to get the mean by activity and by subject	Req: 5. Average of each variable for each activity and each subject.
Write the result to output file

An example of the usage of the result is used in a Xtab call. 
An example of reading the output file back into R is included in the script. 



Data Set License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors 
or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
"# coursera_JohnH_DataGatherCourseProject" 
"# coursera_JohnH_DataGatherCourseProject" 
