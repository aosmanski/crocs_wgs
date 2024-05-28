import sys
import os
from Bio import AlignIO

def count_patterns(alignment):
    abba_count = 0
    baba_count = 0
    for i in range(len(alignment[0])):
        bases = [seq[i] for seq in alignment]
        if bases[0] == bases[2] and bases[1] == bases[3] and bases[0] != bases[1]:
            abba_count += 1
        elif bases[0] == bases[3] and bases[1] == bases[2] and bases[0] != bases[1]:
            baba_count += 1
    return abba_count, baba_count

def calculate_d_statistic(abba, baba):
    numerator = abba - baba
    denominator = abba + baba
    if denominator == 0:
        return 0
    return numerator / denominator

def main():
    if len(sys.argv) != 2:
        print("Usage: python script.py <input_fasta_file>")
        sys.exit(1)

    input_file = sys.argv[1]

    # Read the aligned FASTA file
    alignment = AlignIO.read(input_file, "fasta")

    # Count ABBA and BABA patterns
    abba, baba = count_patterns(alignment)

    # Calculate D-statistic
    d_statistic = calculate_d_statistic(abba, baba)

    # Extract the desired information from the file name
    file_name = os.path.basename(input_file)
    ortho_group = file_name.split(".SCORTHO.")[1].split(".aln.SL.fas")[0]

    # Output the results in columns
    print(f"{ortho_group}\t{abba}\t{baba}\t{d_statistic}")

if __name__ == "__main__":
    main()
