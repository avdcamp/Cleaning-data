Cleaning-data
=============

My cleaning data assignment

The script run_analysis.R works (as commented) in te following way:
1. it takes the unzipped contents from the UCI HAR dataset
2. it starts to read the necessary raw data, being the test and training set.
3. Furthermore we need the activity labels, subjects, activities and the column header names.

First we set the column header names of the test and train set as specified in the column headers file
Then we append the subject ID and activity ID to the test and training set.
We nog have 2 dataframes with 563 columns.
Then we enrich with the activity description, merging based on the activity ID.
This ends up with 2 dataframes with 564 columns.

Now we merge them together using rbind into 1 big dataset.

In order to subset only the mean() and std() columns we create 2 vectors that hold the matching column names.
There are also other columns that have 'mean' in their description, but in my interpretation we strictly
need the mean() and std() column names as part of our tidy dataset.

These logical vectors are summarized so we have the total set of columns that are in scope. As we also need the 2nd and 3rd column (which are the subject ID and the activity description) we set those to true manually.

Based on the subsetting vector we create the tidy dataset with only 68 columns.

The aggregate function enables us to get the average on subject/activity level, ending up with a tidy dataset of 68 columns 
and (6 * 30)= 180 rows. As the aggregate function introduces 2 new columns in the dataset with rather technical names,
I remove the original columns for activity description and subject ID and rename the ones that are generated using the
aggregate function. 

Finally we write the tidySet dataframe into a file.

