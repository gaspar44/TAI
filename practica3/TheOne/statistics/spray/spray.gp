set terminal postscript  color eps 20
set encoding iso_8859_1

#set terminal    gnuplot recommends setting terminal before output
set key top left
set key box

#set yrange [0:120]
#set xrange [0.1:1]

set pointsize 3
set grid

set xlabel "Number of msg copies [1:100]"
set ylabel "Delivery Ratio ([0:1])"
set output "spraydelivery.eps"
f(x) = 0.3086
plot  "spraydelivery.data"    using 1:2 title 'SprayAndWait' ls 5 w points, f(x) title 'Epidemic' w lines

set xlabel "Number of msg copies [1:100]"
set ylabel "Latency (seconds)"
set output "spraylatency.eps"
g(x) = 817.5529
plot  "spraylatency.data"    using 1:2 title 'SprayAndWait' ls 5 w points, g(x) title 'Epidemic' w lines


