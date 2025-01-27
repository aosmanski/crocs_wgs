import os

# Directory containing the phylip files
directory = "/lustre/scratch/aosmansk/crocs/phynest/HyDe/SCORTHO_phylips"

# Output file name
output_file = "SCORTHOS.supermatrix.phy"

# Dictionary to store species and their concatenated sequences
species_sequences = {}

# Iterate over the phylip files in the directory
for filename in os.listdir(directory):
    if filename.endswith(".phy"):
        # Open each phylip file
        with open(os.path.join(directory, filename), "r") as infile:
            # Read the first line to get the number of sequences and sequence length
            first_line = infile.readline().split()
            num_sequences = int(first_line[0])
            sequence_length = int(first_line[1])

            # Read the sequences
            for _ in range(num_sequences):
                line = infile.readline().strip()
                species, sequence = line.split()

                # Concatenate the sequence to the corresponding species in the dictionary
                if species not in species_sequences:
                    species_sequences[species] = ""
                species_sequences[species] += sequence

# Open the output file in write mode
with open(output_file, "w") as outfile:
    # Write the total number of species and the concatenated sequence length
    num_species = len(species_sequences)
    concatenated_sequence_length = len(next(iter(species_sequences.values())))
    outfile.write(f"{num_species} {concatenated_sequence_length}\n")

    # Write the concatenated sequences for each species
    for species, sequence in species_sequences.items():
        outfile.write(f"{species} {sequence}\n")
