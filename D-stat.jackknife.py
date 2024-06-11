import sys
import numpy as np
from scipy.stats import ttest_1samp, norm

def calculate_z_score(d_statistics):
    mean_d_stat = np.mean(list(d_statistics.values()))
    std_dev_d_stat = np.std(list(d_statistics.values()))
    z_scores = {gene_id: (d_stat - mean_d_stat) / std_dev_d_stat for gene_id, d_stat in d_statistics.items()}
    return z_scores

def bootstrap_t_test(d_statistics, num_bootstraps=1000):
    bootstrap_t_stats = []
    for _ in range(num_bootstraps):
        bootstrap_sample = np.random.choice(list(d_statistics.values()), size=len(d_statistics), replace=True)
        t_stat, _ = ttest_1samp(bootstrap_sample, 0)
        bootstrap_t_stats.append(t_stat)
    return bootstrap_t_stats

def bootstrap_z_score(d_statistics, num_bootstraps=1000):
    bootstrap_z_scores = []
    for _ in range(num_bootstraps):
        bootstrap_sample = np.random.choice(list(d_statistics.values()), size=len(d_statistics), replace=True)
        z_scores = calculate_z_score(dict(zip(d_statistics.keys(), bootstrap_sample)))
        bootstrap_z_scores.extend(list(z_scores.values()))
    return bootstrap_z_scores

def block_jackknife(d_statistics, block_size=1000):
    # Add a small constant value to each D-statistic
    d_statistics = {gene_id: d_stat + 0.0001 for gene_id, d_stat in d_statistics.items()}

    n_blocks = max(1, len(d_statistics) // block_size)
    block_size = len(d_statistics) // n_blocks
    pseudovalues = []
    for i in range(n_blocks):
        start = i * block_size
        end = (i + 1) * block_size
        block_d_statistics = dict(list(d_statistics.items())[:start] + list(d_statistics.items())[end:])
        block_mean = np.mean(list(block_d_statistics.values()))
        pseudovalue = len(d_statistics) * np.mean(list(d_statistics.values())) - (len(d_statistics) - block_size) * block_mean
        pseudovalues.append(pseudovalue)
    D_jackknife = np.mean(pseudovalues)
    D_sd = np.std(pseudovalues, ddof=1) if len(pseudovalues) > 1 else 0
    D_err = D_sd / np.sqrt(n_blocks)
    D_Z = D_jackknife / D_err if D_err != 0 else 0
    D_p = 2 * norm.sf(abs(D_Z))
    return D_jackknife, D_err, D_Z, D_p

def main():
    if len(sys.argv) != 2:
        print("Usage: python script.py <input_file>")
        sys.exit(1)

    input_file = sys.argv[1]

    d_statistics = {}
    total_abba = 0
    total_baba = 0

    with open(input_file, 'r') as file:
        for line in file:
            values = line.strip().split()
            if len(values) == 4:
                gene_id = values[0]
                abba_count = int(values[1])
                baba_count = int(values[2])
                d_stat = float(values[3])
                d_statistics[gene_id] = d_stat
                total_abba += abba_count
                total_baba += baba_count

    overall_d_stat = (total_abba - total_baba) / (total_abba + total_baba)

    # Block jackknife
    D_jackknife, D_err, D_Z, D_p = block_jackknife(d_statistics)

    # Initialize the significant variable
    significant = "No"

    # Interpret the significance of the jackknife results
    alpha = 0.05
    if D_p < alpha:
        significant = "Yes"

    # Print the header and the final output line
    print("SPECIES\tABBA\tBABA\tD-stat\tD-stat_JK\tStnd_Err\tZ-Score_JK\tP-value_JK\tSignificant")
    print(f"{input_file}\t{total_abba}\t{total_baba}\t{overall_d_stat}\t{D_jackknife}\t{D_err}\t{D_Z}\t{D_p}\t{significant}")

if __name__ == '__main__':
    main()

