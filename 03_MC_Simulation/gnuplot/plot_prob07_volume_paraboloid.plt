set terminal pdfcairo enhanced color font "CMU Serif,16" size 6,5
set output 'plots/prob07_sampling.pdf'

set title "Monte Carlo 2D Integration Sampling (N=1000)" font ",16"
set xlabel "X" font ",16"
set ylabel "Y" font ",16"
set zlabel "Z = X^2 + Y^2" rotate by 90 offset 1,0
set grid
set xrange [0:1]
set yrange [0:1]

# Define the exact surface to draw as a wireframe
f(x,y) = x**2 + y**2
set isosamples 50
set hidden3d

splot f(x,y) with lines lc rgb "gray" title "Exact Surface", \
      'data/prob07_sampling.dat' using 1:2:3 with points pt 7 ps 0.3 lc rgb "red" title "Sampled Points" nohidden3d
reset

# ============================================================================
set terminal pdfcairo enhanced font "CMU Serif,16" size 8,6
set output "plots/prob07_error.pdf"

set title "Monte Carlo Integration Error Convergence" font ",20"
set logscale xy 10
set xlabel "Number of Iterations (N)" font ",18"
set ylabel "Absolute Error (units of integral)" font ",18"
set grid

f_log(x) = A + b*x
A = log10(1.1)
b = -0.5

set fit quiet
fit f_log(x) "data/prob07_error.dat" using (log10($1)):(log10($2)) via A, b

a = 10**A
g(x) = a * x**b

fit_title = sprintf("Fitted Trend: E = %.4f * N^{%.4f}", a, b)

plot 'data/prob07_error.dat' using 1:2 with points pt 7 ps 0.8 lw 2 lc rgb "royalblue" title "Actual Error", \
     g(x) with lines linetype 2 linewidth 2 lc rgb "orange-red" title fit_title