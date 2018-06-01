from lifelines import KaplanMeierFitter
import pandas as pd


class KaplanMeier:

    # class constructor
    def __init__(self):
        "KaplanMeier" # this is a documentation string which can be accessed via KaplanMeier.__doc__

    # perform the analytic
    def run_analytic(self, data):

        # separate the data by columns
        failure_time = pd.DataFrame(data['failuretime'])
        failure_status = pd.DataFrame(data['failurestatus'])

        # create an instance of KaplanMeierFitter
        kmf = KaplanMeierFitter()

        # fit survival regression model to data
        kmf.fit(failure_time, failure_status)

        # get the predicted values of the survival function
        predicted = kmf.survival_function_

        # create lists of the predicated estimates and indices
        time_line = [t for t in predicted.index]
        estimate = [e for e in predicted['KM_estimate']]

        # return the data in json format
        return {"time_line": time_line, "KM_estimate": estimate}

