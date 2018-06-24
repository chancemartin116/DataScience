from sklearn.ensemble import RandomForestClassifier
from sklearn import preprocessing
import pandas as pd
import random as rm

# store csv file in data frame
bank = pd.read_csv("../data/bank.csv", delimiter=";")

# create a LabelEncoder instance
le = preprocessing.LabelEncoder()

# change categorical data to numerical data for fitting model
# i.e. for bank['y'], no = 0, yes = 1
c = bank.columns.values
i = 0
while i < len(c):
    if bank[c[i]].dtype == 'object':
        le.fit(bank[c[i]])
        bank[c[i]] = le.transform(bank[c[i]])
    i += 1

# set seed value to recreate same random values
rm.seed(123)

# split the data frame into training and test sets
train_sample = rm.sample(range(4521), 3000)
test_sample = [x for x in range(4521) if x not in train_sample]
bank_train = bank.iloc[train_sample,]
bank_test = bank.iloc[test_sample,]

# fit data to random forest
rfc = RandomForestClassifier(n_estimators=10000)
rfc.fit(bank_train.iloc[:, 0:16], bank_train['y'])

# get list of predicted labels for test set
pred_vals = rfc.predict(bank_test.iloc[:, 0:16])

# create a table of predicted outcomes compared to actual results
# the sum of the entries along the main diagonal are the number of correctly predicted labels
print(pd.crosstab(pred_vals, bank_test['y']))

# get ratio of correctly labeled samples to total samples
score = rfc.score(bank_test.iloc[:, 0:16], bank_test['y'])
print("prediction accuracy: ", score)