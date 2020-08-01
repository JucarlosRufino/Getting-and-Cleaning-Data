# Getting-and-Cleaning-Data
Project
Coursera -Getting - and - Cleaning -Data-Course -Project - Jucarlos

The project uses the practice of clearing representative data through the Coursera course. The included R script, run_analysis.R, conducts the following:

1) Download the dataset from web if it does not already exist in the working directory;
2) Read both the train and test datasets and merge them into x(measurements), y(activity) and subject, respectively;
3) Load the data(x's) feature, activity info and extract columns named 'mean'(-mean) and 'standard'(-std);
4) Extract data by selected columns(from step 3), and merge x, y(activity) and subject data;
5) replace y(activity) column to it's name by refering activity label (loaded step 3);
6) Generate 'Tidy Dataset' that consists of the average of each variable for each subject and each activity.


Performing the steps described above generates the result in the file tidy_dataset.txt.
