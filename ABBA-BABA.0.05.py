import sys
import numpy as np
from scipy.stats import ttest_1samp

def main():
    if len(sys.argv) != 2:
        print("Usage: python script.py <input_file>")
        sys.exit(1)

    input_file = sys.argv[1]

    d_statistics = []

    with open(input_file, 'r') as file:
        for line in file:
            values = line.strip().split()
            if len(values) == 4:
                d_stat = float(values[3])
                d_statistics.append(d_stat)

    d_statistics = np.array(d_statistics)
    mean_d_stat = np.mean(d_statistics)

    t_stat, p_value = ttest_1samp(d_statistics, 0)

    print("Average D-statistic:", mean_d_stat)
    print("T-statistic:", t_stat)
    print("P-value:", p_value)

    alpha = 0.05
    if p_value < alpha:
        print("The average D-statistic is significantly different from zero (p < 0.05).")
        if mean_d_stat > 0:
            print("There is evidence of gene flow from the third species (cMin) to the second species (cSia).")
        else:
            print("There is evidence of gene flow from the third species (cMin) to the first species (cJoh).")
    else:
        print("The average D-statistic is not significantly different from zero (p >= 0.05).")
        print("There is no significant evidence of ancestral hybridization based on the ABBA-BABA test.")

if __name__ == '__main__':
    main()
