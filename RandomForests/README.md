#Random Forest
[Random forest](https://www.stat.berkeley.edu/~breiman/RandomForests/cc_home.htm) is a group of [decision or classification trees](https://en.wikipedia.org/wiki/Decision_tree_learning).  Each tree is built from a random subset of the training data.  
The bank dataset for [ClassificationTrees](https://github.build.ge.com/212449799/DataScience/tree/master/ClassificationTrees) is reused for this example.  After running each example, you can compare the prediction accuracies of each classifier.

To run the scripts the following libraries/packages will need to be installed:    
Open the R interpreter and type
```R
# package for creating random forest
install.packages("randomForest")

# package consisting of tools for model fitting
install.packages("gmodels")
```  
For the Python script, type the following at the command line
```bash
# install library containing machine learning tools
pip install sklearn
```