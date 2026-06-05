#!/bin/bash

# ==== CONFIGURATION ====
TOTAL_CPUS=32
CPUS_PER_JOB=32
JOBS_AT_ONCE=$((TOTAL_CPUS / CPUS_PER_JOB))

LAMMPS_EXEC="lmp_mpi"
LAMMPS_INPUT="PipeEdge_Zn_in_CuZn_Formation_energy.in"

OUTPUT_FILE="Zn_vacancy_energies_Edge_core35.txt"

# Original dump-style ID file
ID_FILE="core_Zn_ids_after_min_edge_873K_Fixed_CorrectPipe.txt"

# Clean numeric-only ID file
CLEAN_ID_FILE="Zn_IDs_clean.txt"

# ===== Create clean ID list from LAMMPS dump =====
awk '
  BEGIN {read_atoms=0}
  /^ITEM: ATOMS/ {read_atoms=1; next}
  read_atoms==1 && $1 ~ /^[0-9]+$/ && $2 == 2 {print $1}
' ${ID_FILE} > ${CLEAN_ID_FILE}

echo "Number of Zn IDs extracted:"
wc -l ${CLEAN_ID_FILE}

echo "First few IDs:"
head ${CLEAN_ID_FILE}

# Check for bad lines
BAD_LINES=$(grep -vE '^[0-9]+$' ${CLEAN_ID_FILE} | wc -l)
if [ "$BAD_LINES" -ne 0 ]; then
    echo "ERROR: Clean ID file still contains non-numeric lines."
    grep -vE '^[0-9]+$' ${CLEAN_ID_FILE}
    exit 1
fi

# ===== Output header =====
echo "Atom_ID    E_Vac_Cell" > ${OUTPUT_FILE}

# ===== Run vacancy jobs =====
cat ${CLEAN_ID_FILE} | xargs -n 1 -P ${JOBS_AT_ONCE} bash -c \
'mpirun -np '"${CPUS_PER_JOB}"' '"${LAMMPS_EXEC}"' -var ATOMID "$0" -in '"${LAMMPS_INPUT}"