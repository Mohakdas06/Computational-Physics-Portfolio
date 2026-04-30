# Numerical Solutions using the Finite Difference Method

## Overview
Numerical solutions to the time-independent Schrödinger equation for 14 quantum mechanical potentials using the Finite Difference Method (FDM). Eigenvalues and  eigenfunctions are computed via matrix diagonalisation. Results are compared against analytical solutions where available.

## Numerical Methods

The core of this project is based on the finite difference method. This technique discretizes the spatial domain into small segments, allowing the differential equations governing quantum systems to be transformed into a system of linear algebraic equations. The solutions to these equations provide approximate values for the wavefunctions and eigenvalues.

## Potentials Solved
| Problem | Potential                          |
|---------|------------------------------------|
| 01      | Infinite square well (slanted base)|
| 02      | Half harmonic oscillator           |
| 03      | Harmonic oscillator                |
| 04      | Finite square well                 |
| 05      | Infinite well (parabolic base)     |
| 06      | V = |x|                            |
| 07      | V = |x|³                           |
| 08      | Quartic potential                  |
| 09      | Quartic-quadratic potential        |
| 10      | Half cubic                         |
| 11      | Half quartic                       |
| 12      | Double well                        |
| 13      | Morse potential                    |
| 14      | Dirac delta potential              |

## Project Structure
- src/shared/      — Shared modules (constants, FDM toolbox)
- src/problems/    — One Fortran program per potential
- scripts/         — Python plotting scripts (one per problem)
- output/          — Numerical output from Fortran programs (.txt)
- plots/           — Generated figures embedded in the report
- Makefile         — Builds all Fortran executables
- Makefile.plots   — Runs all Python scripts to regenerate plots

## Dependencies
- Fortran compiler: gfortran >= 9.0
- Python >= 3.8 with: numpy, matplotlib
- LaTeX distribution (for report compilation): pdflatex

## How to Build and Run
### Compile all programs
```bash
make
```

### Run a specific problem (executables written to bin/)
```bash
./bin/prob03_harmonic_oscillator
```

### Regenerate all plots from existing output
```bash
make -f Makefile.plots
```

## Shared Modules
- constants_mod.f90   — Physical constants and grid parameters
- FDM_toolbox.f90     — Core FDM routines: matrix assembly,
                      tridiagonal solver, normalisation

## Report
- FDM_Assignment.pdf  — Full report with derivations, results,
                      and comparison with analytical values
- FDM_Assignment.tex  — LaTeX source

## Author
Mohak Das
Jadavpur University, 2026
Quantum Mechanics