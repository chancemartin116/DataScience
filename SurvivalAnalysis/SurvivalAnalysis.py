import matplotlib.pyplot as plt
import pandas as pd
from lifelines import KaplanMeierFitter, WeibullFitter

# read csv file and store data in data frame
df = pd.read_csv('../data/engine.csv')

# separate data by columns
T = df['failuretime']
E = df['failurestatus']

######### Kaplan Meier estimator ########
kmf = KaplanMeierFitter()

# fit survival model to data
kmf.fit(T, E)

# add curve to plot
ax = kmf.plot()

######## Weibull Distribution ############
wf = WeibullFitter()

# fit survival regression model to data
wf.fit(T, E)

# add predicted survival curve to plot
ax = wf.survival_function_.plot(ax=ax)

# label axes and title
plt.ylabel('Survival Probability')
plt.xlabel('Survival Time')
plt.title('Survival Probability: Engine Breakdown')

# show plot
plt.show()


