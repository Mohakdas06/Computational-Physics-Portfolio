set terminal pdfcairo enhanced color font "CMU Serif,16" size 6,6
set output 'plots/prob05_sampling.pdf'

set title "Monte Carlo Integral Sampling: Mean-value (N=1000)" font ",18"
set size square
set xlabel "x" font ",18"
set ylabel "y" font ",18"
set xrange [0:2]
set grid

f(x) = exp(-x**2)

plot f(x) w l lw 3 lc 'orange-red' title "f(x) = e^{-x^2}", \
    'data/prob05_sampling.dat' using 1:2 with points pt 7 ps 0.4 lc "royalblue" title "Random Points"
reset

# ============================================================================
set terminal pdfcairo enhanced font "CMU Serif,16" size 8,6
set output "plots/prob05_value_conv.pdf"

set title "Monte Carlo Integration Error Convergence" font ",20"
set logscale x 10
set xlabel "Number of Iterations (N)" font ",18"
set ylabel "Estimated Values" font ",18"
set grid

g(x) = sqrt(pi)/2

plot 'data/prob05_value_conv.dat' using 1:2 w lp pt 7 ps 0.8 lw 2 lc rgb "royalblue" notitle