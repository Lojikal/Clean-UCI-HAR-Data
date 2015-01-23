### Usage Instructions
Have the 'UCI HAR Dataset' in the same working dir as run_analysis.R. 
##### Usage Example
source('run_analysis.R')

#### run_analysis.R Processes
* run_analysis will download the zip file if a 'UCI HAR Dataset' is not found in the working directory. 
.* This may take some time depending on your connection speeds.
..* The zip file will be downloaded into the 'UCI HAR Download' directory which will be created fi it doesn't already exist.
.* After the zip file for the data is downloaded the program will extract the file and continue normal runtime.
* run_analysis will then run in table data from the training, subject, and test text files in the subdirectory 'UCI HAR Dataset'.
* Each pair 'X' and 'y' of train, testing, and subject data are appended to Create yData, xData, and subjectData
* 'features.txt' is read and used to remap the columns for the xData set
.* Mean and Standard Deviation is subsetted from xData and the columns changed for clarity
* Numerical values in the yData set are mapped to string pulled from the 'activity_labels.txt'
* Clomuns names for yData and Subject are renamed
* All data sets are merged by columns to create mergedData set
* NewTidyDataSet is created from mergedData by averaging over subject and activity
* NewTidyDataSet is written to file 'UCI HAR Tidy Data.txt'
