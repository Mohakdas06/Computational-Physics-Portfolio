# Define our GNUPlot named colors
color1 = "dark-violet"
color2 = "orange-red"
c_x = "#9400D3"
c_y = "#228B22"
c_z = "#0000FF"

# ===================================================
# PLOT 1: 3D Attactor (x vs y vs z)
# ===================================================

set term pdfcairo size 12in,6in  enhanced font 'CMU Serif, 18'
set output 'plots/prob03_1_lorenz_attractor.pdf'

set multiplot layout 1, 2 title " "

set xlabel "x"
set ylabel "y"
set zlabel "z"

set view 81, 48, 1, 1.5
set xyplane relative 0
set grid
unset key

set title "Lorenz Butterfly for initial condition (1, 2, -4)" font 'CMU Serif, 20'
splot 'data/prob03_lorenz_butterfly.dat' index 0 using 2:3:4 w l lc rgb color1 lw 1.5

set title "Lorenz Butterfly for initial condition (30, -40, 10)" font 'CMU Serif, 20'
splot 'data/prob03_lorenz_butterfly.dat' index 1 using 2:3:4 w l lc rgb color2 lw 1.5

unset multiplot


# ===================================================
# PLOT 3: 2D Projection (z vs x)
# ===================================================

set term pdfcairo size 12in,6in  enhanced font 'CMU Serif, 18'
set output 'plots/prob03_2_lorenz_attractor_x_z.pdf'

set multiplot layout 1, 2 title " "

set xlabel "x"
set ylabel "z"

unset grid
unset key

set title "z vs x for initial condition (1, 2, -4)" font 'CMU Serif, 20'
plot 'data/prob03_lorenz_butterfly.dat' index 0 using 2:4 w l lc rgb color1 lw 1.5

set title "z vs x for initial condition (30, -40, 10)" font 'CMU Serif, 20'
plot 'data/prob03_lorenz_butterfly.dat' index 1 using 2:4 w l lc rgb color2 lw 1.5

unset multiplot


# ===================================================
# PLOT 3: Time series (x, y, z vs t)
# ===================================================

set term pdfcairo size 12in,12in  enhanced font 'CMU Serif, 18'
set output 'plots/prob03_3_lorenz_attractor_x_y_z_t.pdf'

set multiplot layout 2, 1 title " "

set border 3
set tics nomirror

set xlabel "t"
set ylabel "x, y, z"
set xrange [0:100]

set key bottom center horizontal outside

set title "x, y and z vs t for initial condition (1, 2, -4)" font 'CMU Serif, 20'
plot 'data/prob03_lorenz_butterfly.dat' index 0 using 1:2 w l lc rgb c_x lw 1.5 title "x vs t", \
'' index 0 using 1:3 w l lc rgb c_y lw 1.5 title "y vs t", \
'' index 0 using 1:4 w l lc rgb c_z lw 1.5 title "z vs t"

set title "x, y and z vs t for initial condition (30, -40, 10)" font 'CMU Serif, 20'
plot 'data/prob03_lorenz_butterfly.dat' index 1 using 1:2 w l lc rgb c_x lw 1.5 title "x vs t", \
'' index 1 using 1:3 w l lc rgb c_y lw 1.5 title "y vs t", \
'' index 1 using 1:4 w l lc rgb c_z lw 1.5 title "z vs t"

unset multiplot