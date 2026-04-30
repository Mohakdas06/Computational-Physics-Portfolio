set term pdfcairo size 8in,4in enhanced font 'CMU Serif,15'
set output 'plots/prob01_simple_pendulum_gnuplot.pdf'

set border 3
set tics nomirror

set title "Simple Pendulum Phase Portrait" font 'CMU Serif,18'
set xlabel "{/Symbol q} (rad)"
set ylabel "{/Symbol w} (rad/s)"

set xrange [-9:9]
set yrange [-9:9]

unset key

plot 'data/prob01_pendulum.dat' using 2:3 with lines lc "web-blue" lw 2