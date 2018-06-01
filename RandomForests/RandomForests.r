library(randomForest)
library(gmodels)

# store csv file in data frame
bank <- read.csv("data/bank.csv", sep=";")

# set random number generator to produce same results for each run
set.seed(123)

# get random set of 900 integers ranging from 1 to 1000 
train_sample <- sample(4521, 3000)

# split the data frames into training and test sets
# -train_sample means all values not in train_sample
bank_train <- bank[train_sample, ]
bank_test  <- bank[-train_sample, ]

# fmla is equivalent to y = x1 + x2 + ..... 
# create decision tree using formula and training set
# setting keep.forest to true means the forest will be saved in the output
fmla <- paste0("y ~ ", paste0(names(bank[-17]), collapse=" + "))
forestModel <- randomForest(formula=as.formula(fmla), data=bank_train, ntree=10000, keep.forest=T)

# get predicted labels for test set
bank_pred <- predict(forestModel, bank_test, type="response")

# create a table of predicted outcomes compared to actual results
# the sum of the entries along the main diagonal are the number of correctly predicted labels
# row, column and chi-squared proportions are not shown
crossTable <- CrossTable(bank_test$y, bank_pred,
						 prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
						 dnn = c('actual y', 'predicted y'))

# get ratio of correctly labeled samples to total samples
print(paste0("prediction accuracy: ", (crossTable$t[1] + crossTable$t[4]) / sum(crossTable$t)))