set term pdfcairo size 6in,6in enhanced font 'CMU Serif,16'
set output 'plots/prob02_rabbit_sheep_model.pdf'

set title "Phase Portrait (Rabbit and Sheep Model)" font 'CMU Serif,18'
set xlabel "Rabbit"
set ylabel "Sheep"
set xrange [0:3]
set yrange [0:3]

set xtics 1
set ytics 1
set grid
set size square

set key bottom center horizontal outside

f(x) = (3.0 - x)/2.0
g(x) = 2.0 - x

set samples 30
set isosamples 30

dx(x,y) = x*(3.0 - x - 2.0*y)
dy(x,y) = y*(2.0 - x - y)

vlen(x,y) = sqrt(dx(x,y)**2 + dy(x,y)**2)
vlen_safe(x,y) = vlen(x,y) == 0.0 ? 1.0 : vlen(x,y)
scale = 0.08 

$StablePoints << EOD
3 0
0 2
EOD

$UnstablePoints << EOD
0 0
1 1
EOD

plot \
    '++' using 1:2:(dx($1,$2)/vlen_safe($1,$2)*scale):(dy($1,$2)/vlen_safe($1,$2)*scale) \
    title "Flow Field" with vectors head size 0.05,20,60 filled lc "gray70", \
    f(x) title "Rabbit nullcline" w l dt 3 lw 2 lc "black", \
    g(x) title "Sheep nullcline" w l dt 2 lw 2 lc "black", \
    'data/prob02_rabbit_sheep.dat' using 2:3 notitle w l lw 2 lc "web-blue", \
    $StablePoints using 1:2 title "Stable equilibrium" with points pointtype 7 pointsize 1.5 linecolor "black", \
    $UnstablePoints using 1:2 title "Unstable equilibrium" with points pointtype 6 pointsize 1.5 linecolor "black" linewidth 2