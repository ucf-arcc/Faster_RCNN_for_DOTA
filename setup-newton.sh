#!/bin/bash

host=`hostname`

if [[ ! "$host" =~ ^ev ]]; then
	echo "ERROR: this must be run on the Newton GPU cluster!"
	exit 1;
fi


#if module is-loaded cuda; then

#	echo "ERROR: The only module that should be loaded is anaconda2! Do not load the CUDA module!"
#	exit 1;

#elif ! module is-loaded anaconda/anaconda2-5.3.0 && conda info --envs | grep -q ^deeplearning-gpu[[:space:]]*\\*; then
#	echo "ERROR: you must load the anaconda/anaconda2-5.3.0 module and activate the deeplearning-gpu environment!"
#	exit 1

#fi

module load cuda/cuda-9.0

echo "now launching a SLURM job to build the software. This may take a few minutes..."
echo ""
srun -n1 -c4 --gres=gpu:1 --time=1:00:00 --pty ./init.sh

if [[ $? -ne 0 ]]; then
	echo "ERROR: something failed in the build..."
	exit 1
fi

echo "Build complete!"
