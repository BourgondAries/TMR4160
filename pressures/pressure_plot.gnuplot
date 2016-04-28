reset
set terminal pngcairo size 2000,2000 enhanced font 'Verdana,10'
set output filename.".png"

# f(x,y)=sin(1.3*x)*cos(.9*y)+cos(.8*x)*sin(1.9*y)+cos(y*.2*x)
# set xrange [-5:5]
# set yrange [-5:5]
# set isosample 250, 250
# set table 'test.dat'
# splot f(x,y)
# unset table
#
# set contour base
# set cntrparam level incremental -3, 0.5, 3
# unset surface
# set table 'cont.dat'
# splot f(x,y)
# unset table

reset
set xrange [-0.1:1.1]
set yrange [-0.1:1.1]
#set grid ytics mytics xtics mxtics
#set style fill solid
#set ytics 1.0/(n-1)
#set xtics 1.0/(n-1)
#set grid front
#set grid
#unset key
set palette rgbformulae 33,13,10
set label "dt: ".dt at graph 0.2,0.98 center font "Verdana,24"
set label "Max Pressure: ".max_val at graph 0.5,0.98 center font "Verdana,24"
set label "Min Pressure: ".min_val at graph 0.5,0.95 center font "Verdana,24"
set label "Frame: ".filename at graph 0.5,0.05 center font "Verdana,24"
set label "Time: ".time at graph 0.5,0.02 center font "Verdana,24"
set label "Reynolds: ".re at graph 0.1,0.02 center font "Verdana,24"
set label "Tmax: ".tmax at graph 0.1,0.05 center font "Verdana,24"
set label "n: ".n at graph 0.8,0.05 center font "Verdana,24"
set label "ideal dt: ".ideal_dt at graph 0.8,0.02 center font "Verdana,24"
p filename.".image" with image
