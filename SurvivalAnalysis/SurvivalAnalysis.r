# imports library with survival analysis tools
library(survival)

# read csv file and store data in data frame
# header=T means the first row are the column headers
# stringsAsFactors=FALSE means character vectors will not change to factors
df = read.csv('data/engine.csv',  header=T, stringsAsFactors=FALSE)

# creates a survival object using time of event and event status (0=alive, 1=dead)
surv_obj = Surv(df$failuretime, df$failurestatus==1)

######### Kaplan Meier estimate: estimates survival function ################

# creates survival curve 
# the ~ operator usually separates dependent from independent variables in a formula like
# y ~ x is equivalent to y = x
# the ~ 1 below means there is only one curve
model_surv <- survfit(surv_obj ~ 1)

# plot survival curve
# conf.int=T will plot the confidence intervals, defaults to 95%
# confidence interval provides a range of values which is likely to contain the population parameter of interest.
# seen as ---- on both sides of curve
plot(model_surv, conf.int=T, xlab="Survival Time", ylab="Survival Probability",
     main=paste('Surv Probability:', 'Engine Breakdown'), col="blue")

########### Weibull Distribution ###############

# creates a survival regression model using Weibull distribution
model_weibull = survreg(surv_obj ~ 1, dist="weibull")

# predicted survival curve
x = predict(model_weibull, newdata=df[6,], type="quantile", p=seq(0.01, 0.99, length=200))
y = seq(0.99, 0.01, length=length(x))

# add predicted curv to present plot
lines(x, y, type="l", col='green')

# add legend to plot
legend(x="topright", legend=c("KM_estimate", "Weibull_estimate"), lty=1, col=c("blue", "green"))





