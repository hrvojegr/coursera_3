README.md

run_analysis.R is well described within comments for each step or group of steps. It has to be within SAMSUNG's subfolder "UCI HAR Dataset" along with "features.txt" and two subfolders "test" and "train" that include original files.

For example, in my case:

setwd("C:/R/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")

All needed tasks were incorporated into a single script - no external script loading is needed.

Names of variables were customized by make.names() - this makes them safe and unique. I found no need to manually adjust them any further.

At the end script exports data to a file in a working directory ("tidy.txt").

Code book is supplied in code_book.md file.
