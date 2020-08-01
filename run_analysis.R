# run_analysis.R

#0. prepare LIBs
library(reshape2)


#1. get dataset from web
rDataDir <- "./rawData"
rDataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
rDataFilename <- "rawData.zip"
rDataDFn <- paste(rDataDir, "/", "rawData.zip", sep = "")
dataDir <- "./data"

if (!file.exists(rDataDir)) {
  dir.create(rDataDir)
  download.file(url = rDataUrl, destfile = rDataDFn)
}
if (!file.exists(dataDir)) {
  dir.create(dataDir)
  unzip(zipfile = rDataDFn, exdir = dataDir)
}


#2. merge {train, test} data set
# refer: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# train data
Xtrain <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/X_train.txt"))
Ytrain <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/Y_train.txt"))
Strain <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/subject_train.txt"))

# test data
Xtest <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/X_test.txt"))
Ytest <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/Y_test.txt"))
Stest <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/subject_test.txt"))

# merge {train, test} data
xdata <- rbind(Xtrain, Xtest)
ydata <- rbind(Ytrain, Ytest)
sdata <- rbind(strain, Stest)


#3. load feature & activity info
# feature info
features <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/features.txt"))

# activity labels
a_label <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/activity_labels.txt"))
a_label[,2] <- as.character(a_label[,2])

# extract feature cols & names named 'mean, std'
selectedCols <- grep("-(mean|std).*", as.character(feature[,2]))
selectedColNames <- feature[selectedCols, 2]
selectedColNames <- gsub("-mean", "Mean", selectedColNames)
selectedColNames <- gsub("-std", "Std", selectedColNames)
selectedColNames <- gsub("[-()]", "", selectedColNames)


#4. extract data by cols & using descriptive name
xdata <- xdata[selectedCols]
allData <- cbind(sdata, ydata, xdata)
colnames(allData) <- c("Subject", "Activity", selectedColNames)

allData$Activity <- factor(allData$Activity, levels = a_label[,1], labels = a_label[,2])
allData$Subject <- as.factor(allData$Subject)


#5. generate tidy data set
meltedData <- melt(allData, id = c("Subject", "Activity"))
tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)

write.table(tidyData, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)
