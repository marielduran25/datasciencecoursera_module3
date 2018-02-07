# Here are the list of information about the Data, steps and the variables used in the Script

## Data Source
 Data was download from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
 while full description of the data can be viewed from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
 
## Steps used in the Analysis
1. Declare libraries that will be used in the script `data.table` and `dplyr`
2. setting working directory `setwd()`
3. read metadata: `feaname` and `actlabel` holds the metadata
4. reading train data: `train_sub` `train_act` `train_fea` hold the train data for subject,activity and feature respectively
5.reading test data : `test_sub` `test_act` `test_fea` hold the test data for subject,activity and feature respectively
6. merge train and test sets: `sub` `acti` `fea` hold the merged data for subject,activity and feature respectively
7. merge all data into one: `AllData` contains the complete data
8. extract data with mean and sd: `extract_data` contains the extracted data
9. give names to Activities in extract_data
10. rename activities with right labels
11. creating new data that is clean with mean of each activity subject and feature: `cleandata` contains the clean independent data
