set term pdfcairo size 6in,6in enhanced font 'CMU Serif,16'
set output 'plots/prob05_pure_quartic.pdf'

set title "Phase Portrait (Pure Quartic Oscillator)" font 'CMU Serif,18'
set xlabel "Position"
set ylabel "Momentum"

set xtics 1
set ytics 1
set grid
set size square

plot 'data/prob05_pure_quartic.dat' using 2:3 notitle w l lw 2 lc "web-blue"