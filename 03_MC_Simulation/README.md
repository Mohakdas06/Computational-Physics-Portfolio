# Numerical Integration using the Monte Carlo Simulation

## Overview
This project demonstrates the use of Monte Carlo methods to solve various mathematical and physical problems. The numerical approach allows us to approximate solutions with a high degree of precision by simulating random events.

## Numerical Methods

### Monte Carlo Integration
- **Monte Carlo Method**: This is the core technique used in this project. The method relies on random sampling to estimate integrals. For two-dimensional integrals, it involves generating random points within a defined region and computing their average.

### Volume Calculations
- **Monte Carlo Volume Calculation**: For calculating volumes of three-dimensional shapes, the method involves random sampling within a bounding box and determining if each point falls inside the desired shape.

## Potentials Solved
| Problem | Potential                                  |
|---------|--------------------------------------------|
| 01      | Area Under a Polynomial Curve              |
| 02      | Area Under a Trigonometric Function        |
| 03      | Area Between Two Curves                    |
| 04      | Area of a Quarter Circle                   |
| 05      | Integration of Gaussian Function           |
| 06      | Volume under surface Z = X + Y             |
| 07      | Volume under a parabolic surface           |
| 08      | Volume of a surface over a circular region |
| 09      | Volume under a Gaussian surface            |
| 10      | Volume between surfaces                    |

## Project Structure
- src/shared/      — Shared modules (constants, monte carlo toolbox)
- src/problems/    — One Fortran program per potential
- gnuplot/         — GNUPlot plotting scripts (one per problem)
- output/          — Numerical output from Fortran programs (.txt)
- plots/           — Generated figures embedded in the report
- Makefile         — Builds all Fortran executables
- Makefile.plots   — Runs all GNUPlot scripts to regenerate plots

## Dependencies
- Fortran compiler: gfortran >= 9.0
- Plotting engine: GNUPlot >= 5.4
- LaTeX distribution (for report compilation): pdflatex

## How to Build and Run
# Compile all programs
``` bash
make
```

# Run a specific problem (executables written to bin/)
``` bash
./bin/prob01_area_under_curve.f90
```

# Regenerate all plots from existing output
``` bash
make -f Makefile.plots
```

## Shared Modules
- constants_mod.f90           — Physical constants and grid parameters
- monte_carlo_toolbox.f90     — Core monte carlo routines: Monte carlo sampling method (1D, 2D)
                              Monte carlo mean-value method (1D, 2D)

## Report
- Monte_Carlo_Assignment.pdf  — Full report with derivations, results, and comparison with analytical values [[Download Full Report (PDF)](./Monte_Carlo_Assignment.pdf)]
- Monte_Carlo_Assignment.tex  — LaTeX source