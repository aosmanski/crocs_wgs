#!/bin/bash
#SBATCH --job-name=MPL.1retic
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --partition=highmem
#SBATCH --nodes=1
#SBATCH --ntasks=128
#SBATCH --mem=256GB

cd /cluster/home/aosmanski/crocs/PhyloNet

java -jar -Xmx256G  /cluster/home/aosmanski/apps/PhyloNet.jar InferNetwork_MPL.1retic.pl128.nex &> InferNetwork_MPL.1retic.pl128.out
