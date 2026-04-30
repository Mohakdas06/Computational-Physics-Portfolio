set terminal pdfcairo font "CMU Serif,16" size 16,6
set output "plots/Velocity_dist.pdf"

set multiplot layout 1,2 title "Comparison of Velocity Distribution For N = 25 and N = 100" font ",22"
set border 3
set tics nomirror
set xlabel "Velocity" font ",18"
set ylabel "Normalized Counts" font ",18"

set title "Velocity Distribution (N = 25)" font ",20"
plot "data_25/Velocity_dist.dat" using 1:2 with lines lw 1.5 lc rgb "#bf84dd" title "Simulation Histogram", \
 "data_25/Velocity_dist.dat" using 1:3 with lines lw 2 lc rgb "#4169E1" title "MB Distribution (Using KE_{avg})", \
 "data_25/Velocity_dist.dat" using 1:4 with lines lw 2 dt 2 lc rgb "#228B22" title "MB Distribution(Using v_{most})"

set title "Velocity Distribution (N = 100)" font ",20"
plot "data_100/Velocity_dist.dat" using 1:2 with lines lw 1.5 lc rgb "#bf84dd" title "Simulation Histogram", \
 "data_100/Velocity_dist.dat" using 1:3 with lines lw 2 lc rgb "#4169E1" title "MB Distribution (Using KE_{avg})", \
 "data_100/Velocity_dist.dat" using 1:4 with lines lw 2 dt 2 lc rgb "#228B22" title "MB Distribution(Using v_{most})"

unset multiplot