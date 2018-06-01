import json
import pandas as pd
import sys

def csv_to_json(input_file, output_file):
    """ Conver dataset from CSV to JSON format
    - First row should be column names.
    - First column should be row names.
    """

    df = pd.read_csv(input_file, index_col=0)

    data = dict()
    for col in df.columns:
        data[col] = df[col].values.tolist()

    with open(output_file, "w") as fp:
        json.dump(data, fp)


if __name__ == '__main__':
    infile = sys.argv[1]
    outfile = sys.argv[2]
    csv_to_json(infile, outfile)
