# Plot trykkfeltet
reset
# Sett bildetype, størrelse, og navn
set terminal pngcairo size 2000,2000 enhanced font 'Verdana,10'
set output filename.".png"

reset
# Sett utseende på plottet og størrelsene
set xrange [-0.1:1.1]
set yrange [-0.1:1.1]
set palette rgbformulae 33,13,10

# Skriv verdiene til plottet
set label "dt: ".dt at graph 0.2,0.98 center font "Verdana,24"
set label "flow: ".flow at graph 0.2,0.95 center font "Verdana,24"
set label "Max Pressure: ".max_val at graph 0.5,0.98 center font "Verdana,24"
set label "Min Pressure: ".min_val at graph 0.5,0.95 center font "Verdana,24"
set label "Frame: ".filename at graph 0.5,0.05 center font "Verdana,24"
set label "Time: ".time at graph 0.5,0.02 center font "Verdana,24"
set label "Reynolds: ".re at graph 0.1,0.02 center font "Verdana,24"
set label "Tmax: ".tmax at graph 0.1,0.05 center font "Verdana,24"
set label "n: ".n at graph 0.8,0.05 center font "Verdana,24"
set label "ideal dt: ".ideal_dt at graph 0.8,0.02 center font "Verdana,24"

# Skriv ut plottet til en bildefil
p filename.".image" with image
