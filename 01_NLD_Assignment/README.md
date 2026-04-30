# Numerical Solutions of System of Non-linear ODE using the Runge-Kutta Method

## Overview
Numerical study of six nonlinear dynamical systems using a shared 5th-order Runge-Kutta (RK5) integrator. Problems span conservative and dissipative systems, fixed-point analysis, strange attractors, and population dynamics.

## Problems
| Problem | System                        | Key Physics                              |
|---------|-------------------------------|------------------------------------------|
| 01      | Simple pendulum               | Phase portrait, nonlinear oscillation    |
| 02      | Rabbit-sheep (Lotka-Volterra) | Competing species, fixed points          |
| 03      | Lorenz system                 | Strange attractor, sensitive dependence  |
| 04      | Bacteria colony               | Vector field / quiver plot               |
| 05      | Pure quartic oscillator       | Anharmonic potential, phase space        |
| 06      | Saddle-centre system          | Fixed point classification, dashboard    |

## Project Structure
- src/shared/
  - constants_mod.f90  — Physical constants and shared parameters
  - RK5_solver.f90     — 5th-order Runge-Kutta integrator (reusable module);
                       accepts any RHS as a subroutine argument, called
                       by all six problem programs

- src/problems/        — One self-contained Fortran program per system;
                       each links against the shared RK5 module

- gnuplot/             — One gnuplot script per problem
- plots/               — Generated figures (PDF); Lorenz system has three
                       views: 3D attractor, x-z projection, x/y/z vs t
- Makefile             — Compiles all six executables
- Makefile.plots       — Runs all gnuplot scripts to regenerate figures

## Dependencies
- Fortran compiler: gfortran >= 9.0
- Plotting engine: GNUPlot >= 5.4
- LaTeX distribution (for report compilation): pdflatex

## How to Build and Run
### Compile all programs
```bash
make
```

### Run a specific system (data written to stdout or temp file)
```bash
./bin/prob03_lorenz_butterfly
```

### Regenerate all plots from existing data
```bash
make -f Makefile.plots
```

### Or regenerate a single plot
```bash
gnuplot gnuplot/plot_prob03_lorenz_butterfly.plt
```

## Numerical Method
All systems are integrated using the shared RK5 module (src/shared/RK5_solver.f90). The solver accepts the RHS of the ODE system as a subroutine argument, making it problem-agnostic. Step size and integration time are set per-problem via constants_mod.f90 or local parameters.

## Report
- NLD_Assignment.pdf  — Full report: phase portraits, attractor plots,
                      fixed-point analysis, and physical interpretation
- NLD_Assignment.tex  — LaTeX source

## Author
Mohak Das
Jadavpur University, 2026
Classical Mechanics