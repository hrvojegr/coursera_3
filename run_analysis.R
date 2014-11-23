train <- read.table("train/X_train.txt")    ## Read data
test <- read.table("test/X_test.txt")
train_act <- read.table("train/Y_train.txt")
test_act <- read.table("test/Y_test.txt")
train_subj <- read.table("train/subject_train.txt")
test_subj <- read.table("test/subject_test.txt")
features_read <- read.table("features.txt")

names(train_act) <- "Activity"              ## Add variable names for activities and subjects
names(test_act) <- "Activity"
names(train_subj) <- "Subject"
names(test_subj) <- "Subject"

features <-as.vector(t(features_read[2]))   ## Get a second column from data frame as a vector (column/variable names)
fixed_features <- make.names(features)      ## Make names of variables safe for use and unique as requested
names(train) <- fixed_features              ## Set column/variable names
names(test) <- fixed_features

train_combined <- cbind(train_subj,train_act,train)             ## Add subject and activity columns in nice order
test_combined <- cbind(test_subj,test_act,test)

merged_data <- rbind(train_combined,test_combined)              ## Merge train_combined and test_combined datasets
selected_columns <- c(grep("mean", fixed_features), grep("std", fixed_features), 562, 563)  ## Extract only columns with "mean" and "std"
selected_data <- merged_data[selected_columns]     

attach(selected_data)                                           ##  Perform aggregation
agg_data <-aggregate(selected_data, by=list(Activity,Subject), FUN=mean)
detach(selected_data)

agg_data$Activity[agg_data$Activity==1] <- "WALKING"            ## Substitute activities
agg_data$Activity[agg_data$Activity==2] <- "WALKING_UPSTAIRS"
agg_data$Activity[agg_data$Activity==3] <- "WALKING_DOWNSTAIRS"
agg_data$Activity[agg_data$Activity==4] <- "SITTING"
agg_data$Activity[agg_data$Activity==5] <- "STANDING"
agg_data$Activity[agg_data$Activity==6] <- "LAYING"

tidy_data <- agg_data[3:83]  ## Remove extra columns added by calculation

rm(fixed_features,selected_columns,merged_data,features_read,features,test,train,train_combined,test_combined,test_act,test_subj,train_subj,train_act,agg_data) ## Cleanup of environment

write.table(tidy_data, file = "tidy.txt", row.name=FALSE)       ## Write tidy data to a .txt file
