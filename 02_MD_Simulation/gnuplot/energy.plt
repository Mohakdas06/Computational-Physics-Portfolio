set terminal pdfcairo font "CMU Serif,16" size 16,6
set output "plots/Energy.pdf"

set multiplot layout 1,2 title "Comparison of Energy Conservation For N = 25 and N = 100" font ",22"

set border 3
set tics nomirror
set xlabel "Time in reduced units" font ",18"
set ylabel "Energy in reduced units" font ",18"
set key center bottom horizontal outside 

set title "Conservation of Energy (N = 25)" font ",20"
plot "data_25/Energy.dat" using 1:2 with lines lw 1.5 lc rgb "#FF6347" title "Kinetic Energy", \
 "data_25/Energy.dat" using 1:3 with lines lw 1.5 lc rgb "#4682B4" title "Potential Energy", \
 "data_25/Energy.dat" using 1:4 with lines lw 2 lc rgb "black" title "Total Energy"

set title "Conservation of Energy (N = 100)" font ",20"
plot "data_100/Energy.dat" using 1:2 with lines lw 1.5 lc rgb "#FF6347" title "Kinetic Energy", \
 "data_100/Energy.dat" using 1:3 with lines lw 1.5 lc rgb "#4682B4" title "Potential Energy", \
 "data_100/Energy.dat" using 1:4 with lines lw 2 lc rgb "black" title "Total Energy"

unset multiplot