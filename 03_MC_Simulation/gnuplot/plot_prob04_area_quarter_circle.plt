set terminal pdfcairo enhanced color font "CMU Serif,16" size 6,6
set output 'plots/prob04_sampling.pdf'

set title "Monte Carlo Integral Estimation: Hit-or-Miss (N=5000)" font ",18"
set size square
set xlabel "x" font ",18"
set ylabel "y" font ",18"
set xrange [0:1]
set yrange [0:1]

f(x) = sqrt(1 - x**2)

plot f(x) w l lw 3 lc 'black' notitle, \
     'data/prob04_sampling.dat' using 1:2:3 with points pt 7 ps 0.4 lc variable notitle