set terminal pdfcairo enhanced color font "CMU Serif,16" size 6,5
set output 'plots/prob09_sampling.pdf'

set title "Monte Carlo 2D Integration Sampling (N=1000)" font ",16"
set xlabel "X" font ",16"
set ylabel "Y" font ",16"
set zlabel "Z = e ^{-(X^2 + Y^2)}" rotate by 90 offset 1,0
set grid
set xrange [-2:2]
set yrange [-2:2]

# Define the exact surface to draw as a wireframe
f(x,y) = exp(-(x**2 + y**2))
set isosamples 100
set hidden3d

splot f(x,y) with lines lc rgb "gray" title "Exact Surface", \
      'data/prob09_sampling.dat' using 1:2:3 with points pt 7 ps 0.3 lc rgb "red" title "Sampled Points" nohidden3d

reset

# ============================================================================
set terminal pdfcairo enhanced font "CMU Serif,16" size 8,6
set output "plots/prob09_value_conv.pdf"

set title "Monte Carlo Integration Error Convergence" font 'CMU Serif,20'
set logscale x 10
set xlabel "Number of Iterations (N)" font ",18"
set ylabel "Estimated Values" font ",18"
set grid


plot 'data/prob09_value_conv.dat' using 1:2 w lp pt 7 ps 0.8 lw 2 lc rgb "royalblue" notitle