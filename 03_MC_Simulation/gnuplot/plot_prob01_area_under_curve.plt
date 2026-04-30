set terminal pdfcairo enhanced color font "CMU Serif,16" size 6,6
set output 'plots/prob01_sampling.pdf'

set title "Monte Carlo Integral Estimation: Hit-or-Miss (N=5000)" font ",18"
set size square
set xlabel "x" font ",18"
set ylabel "y" font ",18"
set xrange [0:1]
set yrange [0:1]

f(x) = x**2

plot f(x) w l lw 3 lc 'black' notitle, \
     'data/prob01_sampling.dat' using 1:2:3 with points pt 7 ps 0.4 lc variable notitle
reset

# ============================================================================
set terminal pdfcairo enhanced font "CMU Serif,16" size 8,6
set output "plots/prob01_error.pdf"

set title "Monte Carlo Integration Error Convergence" font ",20"
set logscale xy 10
set xlabel "Number of Iterations (N)" font ",18"
set ylabel "Absolute Error (units of integral)" font ",18"
set grid

f_log(x) = A + b*x
A = log10(1.1)
b = -0.5

set fit quiet
fit f_log(x) "data/prob01_error.dat" using (log10($1)):(log10($2)) via A, b

a = 10**A
g(x) = a * x**b

fit_title = sprintf("Fitted Trend: E = %.4f * N^{%.4f}", a, b)

plot 'data/prob01_error.dat' using 1:2 with points pt 7 ps 0.8 lw 2 lc rgb "royalblue" title "Actual Error", \
     g(x) with lines linetype 2 linewidth 2 lc rgb "orange-red" title fit_title