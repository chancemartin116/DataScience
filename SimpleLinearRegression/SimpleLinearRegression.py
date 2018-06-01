from scipy import stats
import pandas as pd
import matplotlib.pyplot as plt

# reads csv file and stores data in pandas data frame
weather = pd.read_csv("../data/weather.csv")

# gets columns to be used as x and y values for linear model
temperature = weather['temperature']
days = weather['days']

# fits a linear model to given data
slope, intercept, r_value, p_value, std_error = stats.linregress(x=days, y=temperature)

# equation of a line: y = bx + a
predict_y = slope * days + intercept

# scatter plot of given data
plt.scatter(x=days, y=temperature)

# set range of x-axis of plot
plt.xlim(0, 25)

# plot predicted line: 'k' is black and '-' is solid line
plt.plot(days, predict_y, 'k-')

# label plot title and axes
plt.title('Weather: Temperature vs Days')
plt.xlabel('days')
plt.ylabel('temperature')

# show plot
plt.show()





