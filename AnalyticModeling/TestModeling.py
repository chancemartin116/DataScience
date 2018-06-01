import sys
import os
sys.path.append(os.getcwd())
import analytic
import pandas as pd

# test the analytic locally before pushing to the catalog
def main():
    data = pd.read_json('../data/engine.json')
    kmf = analytic.KaplanMeier()
    result = kmf.run_analytic(data)
    print result

# allows TestModeling.py to be run as a standalone program
# i.e. main() will run when this script is run
if __name__ == '__main__':
    main()

