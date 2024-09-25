import argparse
import re
from scipy.stats import chi2

def extract_lnl(file_path):
    with open(file_path, 'r') as file:
        content = file.read()
        match = re.search(r'lnL\(ntime:.+np:.+\):\s*([-+]?\d*\.\d+|\d+)', content)
        if match:
            return float(match.group(1))
    return None

def main():
    parser = argparse.ArgumentParser(description='Perform likelihood ratio test (LRT) for codeml model2 runs.')
    parser.add_argument('-alt', required=True, help='Input file for the alternative model2')
    parser.add_argument('-nul', required=True, help='Input file for the null model2')
    parser.add_argument('-id', required=True, help='Protein ID')
    args = parser.parse_args()

    lnL_alternative = extract_lnl(args.alt)
    lnL_null = extract_lnl(args.nul)

    if lnL_alternative is None or lnL_null is None:
        print("Error: Could not find lnL values in the input files.")
        return

    lrt_statistic = 2 * (lnL_alternative - lnL_null)
    p_value = 1 - chi2.cdf(lrt_statistic, 1)

    print(f"{args.id} {lnL_alternative} {lnL_null} {lrt_statistic} {p_value}")

if __name__ == '__main__':
    main()
