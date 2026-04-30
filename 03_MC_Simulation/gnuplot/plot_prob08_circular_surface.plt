set terminal pdfcairo enhanced color font "CMU Serif,16" size 12,6
set output 'plots/prob08_multiview.pdf'

set multiplot layout 1,2 title "Monte Carlo 2D Integration Sampling (N=2000)" font ",22"

set xlabel "X" font ",16"
set ylabel "Y" font ",16"
set grid
set xrange [-1:1]
set yrange [-1:1]

f(x,y) = x**2 + y**2
set isosamples 50
set hidden3d

# ==========================================
# PLOT 1: The Academic Standard (Left Side)
# ==========================================
set title "Isometric View" font ",18"
set view 60, 45
splot f(x,y) with lines lc rgb "gray" title "Exact Surface", \
      'data/prob08_sampling.dat' using 1:2:($3==1 ? $4 : NaN) with points pt 7 ps 0.3 lc rgb "red" title "Accepted Points" nohidden3d

# ==========================================
# PLOT 2: The Top-Down Angle (Right Side)
# ==========================================
set title "Top-Down View (Acceptance Region)" font ",18"
unset ztics
set view 20, 30
unset key 
splot f(x,y) with lines lc rgb "gray" notitle, \
      'data/prob08_sampling.dat' using 1:2:($3==1 ? $4 : NaN) with points pt 7 ps 0.3 lc rgb "red" notitle nohidden3d

unset multiplot