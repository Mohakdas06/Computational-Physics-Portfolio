# Numerical Solutions using the WKB Approximation

## Overview
Numerical solutions to the time-independent Schrödinger equation for 11 quantum mechanical potentials using the WKB (Wentzel-Kramers-Brillouin) approximation and numerical integration techniques.

## Numerical Methods

1. **WKB Approximation**: To estimate the eigen energies of quantum systems.
2. **Trapezoidal Integration**: For numerical integration to calculate the action integral in the WKB method.
3. **Bisection Method**: For finding eigen energies solving the algebraic equation obtained from action integral and quantization condition.

## Potentials Solved
| Problem | Potential                           |
|---------|-------------------------------------|
| 01      | Half harmonic oscillator            |
| 02      | Harmonic oscillator                 |
| 03      | Infinite square well                |
| 04      | Infinite square well (slanted base) |
| 05      | Infinite well (parabolic base)      |
| 06      | V = |x|                             |
| 07      | V = |x|³                            |
| 08      | Quartic potential                   |
| 09      | Quartic-quadratic potential         |
| 10      | Half cubic                          |
| 11      | Half quartic                        |

## Project Structure
- src/shared/      — Shared modules (constants, WKB toolbox)
- src/problems/    — One Fortran program per potential
- output/          — Numerical output from Fortran programs (.txt)
- Makefile         — Builds all Fortran executables

## Dependencies
- Fortran compiler: gfortran >= 9.0
- LaTeX distribution (for report compilation): pdflatex

## How to Build and Run
### Compile all programs
```bash
make
```

### Run a specific problem (executables written to bin/)
```bash
./bin/prob02_1D_harmonic
```

### Regenerate all plots from existing output
```bash
make -f Makefile.plots
```

## Shared Modules
- constants_mod.f90   — Physical constants and grid parameters
- FDM_toolbox.f90     — Core WKB routines: wkb integral,
                        integrator, root finder

## Report
- WKB_Assignment.pdf  — Full report with derivations, results,
                        and comparison with analytical values [[Download Full Report (PDF)](./WKB_Assignment.pdf)]
- WKB_Assignment.tex  — LaTeX source