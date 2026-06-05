# Zn Pipe Diffusion in α-Cu64Zn36

This repository contains LAMMPS input files, processed data, and analysis scripts used for the atomistic study of Zn pipe diffusion along edge and screw dislocations in α-Cu64Zn36.

## Contents

### Lammps_input

LAMMPS input files and initial structure files used for the molecular dynamics simulations.

* Diffusion
  Contains the edge and screw dislocation structure files generated using Atomsk, together with representative LAMMPS input scripts for pipe-diffusion simulations.

* Formation_energy
  Contains LAMMPS input scripts and shell scripts used for Zn vacancy formation-energy calculations in the edge and screw dislocation cores.

### Results

Processed data and analysis notebooks used to generate the figures and results reported in the manuscript.

* MSD
  Mean squared displacement data and scripts used to calculate diffusion coefficients.

* Arrhenius_plots
  Data and scripts used for Arrhenius fitting and activation-energy calculations.

* `Vacancy_formation_energies_histograms/`
  Vacancy formation-energy data and scripts used to generate vacancy-energy distributions for bulk, edge, and screw systems.

## Software

The molecular dynamics simulations were performed using LAMMPS. Atomic structures were generated using Atomsk, and post-processing was performed using Python/Jupyter notebooks.

## Notes

Only representative input files and processed datasets are included. Full raw MD trajectory files are not included due to their large size, but they are available from the corresponding author upon reasonable request.


