#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=00:15:00
#SBATCH --cpus-per-task=1
#SBATCH --partition=normal 

node=`hostname -s`
port=`shuf -i 8400-9400 -n 1`

echo "Run the following on your local machine: "
echo "ssh -i /path/to/private/ssh/key -N -L 8888:${node}:${port} ${USER}@spider.surf.nl"

cd ${HOME}

APPTAINER_CMD="apptainer -d exec --bind /tmp,/scratch,/project,/run,/usr,/etc"
APPTAINER_IMAGE="oras://ghcr.io/rs-dat/2025-09-03-eo-summer-school:latest"
PYTHON="${APPTAINER_CMD} ${APPTAINER_IMAGE} python"

export DASK_DISTRIBUTED__DASHBOARD__LINK="/proxy/{port}/status"
export DASK_LABEXTENSION__FACTORY__MODULE="dask_jobqueue"
export DASK_LABEXTENSION__FACTORY__CLASS="SLURMCluster"
export DASK_JOBQUEUE__SLURM__PROCESSES=1
export DASK_JOBQUEUE__SLURM__CORES=4
export DASK_JOBQUEUE__SLURM__MEMORY="30GiB"
export DASK_JOBQUEUE__SLURM__QUEUE="normal"
export DASK_JOBQUEUE__SLURM__DEATH_TIMEOUT=600
export DASK_JOBQUEUE__SLURM__LOCAL_DIRECTORY="\$TMPDIR"
export DASK_JOBQUEUE__SLURM__WALLTIME="10:00:00"
export DASK_JOBQUEUE__SLURM__PYTHON=${PYTHON}

${PYTHON} -m jupyterlab --no-browser --port=${port} --ip=0.0.0.0

