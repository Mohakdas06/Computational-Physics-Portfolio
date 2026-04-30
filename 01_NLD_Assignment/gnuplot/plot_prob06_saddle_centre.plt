set term pdfcairo size 6in,6in enhanced font 'CMU Serif,14'
set output 'plots/prob06_dashboard.pdf'

set title "Phase Portrait Analysis: Saddle & Centre Topology" font 'CMU Serif,18'
set xlabel "Position (x)" font ',14'
set ylabel "Momentum (y)" font ',14'

set xrange [-1:4]
set yrange [-1:4]
set size square
set grid

set key outside center bottom horizontal

dx(x,y) = x + y - y**2
dy(x,y) = x - y

vlen(x,y) = sqrt(dx(x,y)**2 + dy(x,y)**2)
vlen_safe(x,y) = vlen(x,y) == 0.0 ? 1.0 : vlen(x,y)
scale = 0.08 

set samples 30
set isosamples 30

f(x) = x 

g1(x) = x >= -0.25 ? (1.0 + sqrt(1.0 + 4.0*x)) / 2.0 : 1/0  # Upper branch
g2(x) = x >= -0.25 ? (1.0 - sqrt(1.0 + 4.0*x)) / 2.0 : 1/0  # Lower branch

$SaddlePoint << EOD
0 0
EOD

$CentrePoint << EOD
2 2
EOD

plot \
    '++' using 1:2:(dx($1,$2)/vlen_safe($1,$2)*scale):(dy($1,$2)/vlen_safe($1,$2)*scale) \
        title "Vector Flow Field" with vectors head size 0.04,20,60 filled lc "gray85", \
    f(x) title "dy/dt = 0 Nullcline" w l dt 2 lw 2 lc "dark-violet", \
    g1(x) title "dx/dt = 0 Nullcline" w l dt 3 lw 2 lc "dark-orange", \
    g2(x) notitle w l dt 3 lw 2 lc "dark-orange", \
    'data/prob06_saddle_centre.dat' using 2:3 title "System Trajectories" w l lw 2 lc "web-blue", \
    $SaddlePoint using 1:2 title "(0,0) Saddle" with points pt 7 ps 1.2 lc "red", \
    $CentrePoint using 1:2 title "(2,2) Centre" with points pt 7 ps 1.2 lc "dark-green"