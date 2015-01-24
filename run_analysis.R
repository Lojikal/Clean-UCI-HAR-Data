library(plyr)
# Check if the Dataset is the working directory, if it is not download and extract is
if(!file.exists("UCI HAR Dataset")) {
  # sets directory and file name to download data
  fileName <- "./UCI HAR Download/UCI HAR data.zip"
  #Create directory if it doesn't already exist 
  dir.create("UCI HAR Download")
  # Check if file is already downloaded if not download the file
  if(!file.exists(fileName)){
    # URL to download the zip file
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url, fileName)
  }
  unzip(fileName, exdir = ".")
}

# set directories for train and test data files
dirTr <- "UCI HAR Dataset/train"
dirTe <- "UCI HAR Dataset/test"

# READ Training and Test Data sets appending Test Rows to Training
xData <- rbind(read.table(paste(dirTr,"/X_train.txt",sep = "")),read.table(paste(dirTe,"/X_test.txt",sep = "")))
yData <- rbind(read.table(paste(dirTr,"/y_train.txt",sep = "")),read.table(paste(dirTe,"/y_test.txt",sep = "")))
subjectData <- rbind(read.table(paste(dirTr,"/subject_train.txt",sep = "")),read.table(paste(dirTe,"/subject_test.txt",sep = "")))


# Extract Mean and Standard Deviation for each measurement Creating a New subSet
features <- read.table("./UCI HAR Dataset/features.txt")

# subset xData with regex on Features
names(xData) <- features[,2]
xData <- xData[,grep("(mean|std)\\(\\)",features[,2])]

# Clean up the column names a bit
names(xData) <- gsub("-mean\\(\\)","Mean",names(xData))
names(xData) <- gsub("-std\\(\\)","StandardDeviation",names(xData))
names(xData) <- gsub("[-]","",names(xData))

# Read in activity_levels.txt to Rename activities
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")

#replace numerical values in yData with strings from the activity_labels text file
yData[,1] <- activity[yData[,1],2]

# Create a column name for yData
names(yData) <- "Activity"
names(subjectData) <- "SubjectID"

mergedData <- cbind(subjectData,yData,xData)
# Rename Variables with descriptive variable names

# New Tidy Data set with averages of each variable for each Activity and each Subject
NewTidyDataSet <- ddply(mergedData, .(Activity,SubjectID), function(mergedData) colMeans(mergedData[,-c(1,2)]))
write.table(NewTidyDataSet, "UCI HAR Tidy Data.txt",row.name=FALSE)
