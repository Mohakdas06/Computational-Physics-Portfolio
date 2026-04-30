reset
set terminal pdfcairo font "CMU Serif,16" size 12,6
set output "plots/Initial.pdf"

set multiplot layout 1,2 title "Comparison of Initial State for N = 25 and N = 100" font ",22"
set size square
set xlabel "X Position" font ",16"
set ylabel "Y Position" font ",16"
set grid
set key center bottom horizontal outside 
s = 1.0

set title "Position and Velocity of Particles (N = 25)" font ",18"
plot "data_25/Initial.dat" using 1:2:(s*$3):(s*$4) with vectors head filled lw 1.5 lc rgb "#DC143C" title "Velocity Vectors", \
    "data_25/Initial.dat" using 1:2 with points pt 7 ps 1.5 lc rgb "#483D8B" title "Particles"

set title "Position and Velocity of Particles (N = 100)" font ",18"
plot "data_100/Initial.dat" using 1:2:(s*$3):(s*$4) with vectors head filled lw 1.5 lc rgb "#DC143C" title "Velocity Vectors", \
    "data_100/Initial.dat" using 1:2 with points pt 7 ps 1.5 lc rgb "#483D8B" title "Particles"

unset multiplot