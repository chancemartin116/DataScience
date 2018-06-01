from analytic import KaplanMeier

# runs the analytic microservice
def driver(*args, **kwargs):
    """pass on the data to analytic"""
    kmf = KaplanMeier()
    result = kmf.run_analytic(kwargs)
    return result

# function used to get output of analytic
def results(args):
    return args
