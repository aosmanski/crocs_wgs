import sys
import os

def calculate_weighted_average_coverage(coverage_file):
    total_length = 0
    weighted_sum = 0

    with open(coverage_file, 'r') as file:
        next(file)  # Skip the header line
        for line in file:
            fields = line.strip().split()
            contig_length = int(fields[2])
            mean_depth = float(fields[6])

            total_length += contig_length
            weighted_sum += contig_length * mean_depth

    if total_length > 0:
        weighted_average_coverage = weighted_sum / total_length
        return weighted_average_coverage
    else:
        return 0

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: python script.py <coverage_file>")
        sys.exit(1)

    coverage_file = sys.argv[1]
    species = os.path.splitext(os.path.basename(coverage_file))[0]
    weighted_average_coverage = calculate_weighted_average_coverage(coverage_file)
    print(f"{species}\t{weighted_average_coverage:.2f}x")
