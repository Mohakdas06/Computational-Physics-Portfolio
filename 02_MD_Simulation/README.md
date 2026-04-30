# Study of Molecular Dynamics Simulation Using Verlet Algorithm

## Overview
- Classical molecular dynamics simulation of particles interacting via the Lennard-Jones potential. Implements velocity Verlet integration, periodic boundary conditions, and thermostat.
- Observables computed: total/kinetic/potential energy, velocity distribution, and particle configurations at initial and final states.

## Physics
- Potential : Lennard-Jones  V(r) = 4ε[(σ/r)¹² − (σ/r)⁶]
- Integrator: Velocity Verlet (time-reversible, symplectic)
- Ensemble  : Microcanonical (NVE)
- System    : N = 25 and 100 particles, [2D]

## Project Structure
- src/
  - md_params.f90      — System parameters, LJ constants, timestep
  - md_init.f90        — Initial positions and velocities
  - md_forces.f90      — Force and potential energy calculation
  - md_integrator.f90  — Velocity Verlet time-stepping loop
  - md_energy.f90      — Kinetic, potential, and total energy computation
  - md_analysis.f90    — Velocity distribution
  - md_main.f90        — Driver program

- gnuplot/             — Gnuplot scripts for all figures
- plots/               — Generated figures (PDF)
- Makefile             — Builds the simulation executable

## Dependencies
- Fortran compiler: gfortran >= 9.0
- Plotting engine: GNUPlot >= 5.4
- LaTeX distribution (for report compilation): pdflatex

## How to Build and Run
### Compile
```bash
make
```

### Run simulation (output written to stdout or data files)
```bash
./md_sim
```

### Regenerate plots
```bash
gnuplot gnuplot/energy.plt
gnuplot gnuplot/velocity_dist.plt
gnuplot gnuplot/initial.plt
gnuplot gnuplot/final.plt
```

## Results Summary
- Energy conservation verified over [N] timesteps
- Velocity distribution converges to Maxwell-Boltzmann at equilibrium
- Initial configuration : [e.g. FCC lattice]
- Final configuration   : [e.g. equilibrated liquid/gas phase]

## Report
- MD_Simulation.pdf  — Full report: theory, implementation, results [[Download Full Report (PDF)](./MD_Simulation.pdf)]
- MD_Simulation.tex  — LaTeX source