#Codebook

##Description of run_analysis.R script:
* Downloads and unzips the Human Activity Recognition Using Smartphones dataset (see Readme.md)
* Reads the training and test datasets
* Select the measurement variables describing means and standard deviations
* Combines the data sets and assigns descriptive variable names
* Groups the data by subject and activity and summaries the means of the measurements by these two groups.

All transformations and manipulation of data is describes in the notes of script: `run_analysis.R`

The final dataset containing the means of the measurements summarised by subject and activity is stored in:`Sum_all_data_means`

##Groups:
* `subject` - The ID of the test subject
* `activity` - The type of activity performed when the corresponding measurements were taken
