# Survival Analysis
[Survival analysis](https://en.wikipedia.org/wiki/Survival_analysis) analyzes the expected duration of time until an event or events occur like a system failure.
The survival function is the probablity that a subject's survival time _T_ is greater than time _t_. 
The [Kaplan-Meier](http://pages.stat.wisc.edu/~ifischer/Intro_Stat/Lecture_Notes/8_-_Survival_Analysis/8.2_-_Kaplan-Meier_Formula.pdf) estimator is used to estimate the survival function.  The [Weibull distribution](https://en.wikipedia.org/wiki/Weibull_distribution) is one of most widely used distributions dealing with survival analysis. The example scripts use a dataset that provides event times and status for different engine types.

In order to run SurvivalAnalysis.r you will need to install the [survival](https://cran.r-project.org/web/packages/survival/survival.pdf) package by typing the following at the terminal
```r
r # starts the r interpreter
install.packages("survival")
```

To run SurvivalAnalysis.py, install the [lifelines](http://lifelines.readthedocs.io/en/latest/Intro%20to%20lifelines.html) package by downloading
the [source](https://pypi.python.org/pypi/lifelines/) or using pip:
```shell
pip install lifelines
```