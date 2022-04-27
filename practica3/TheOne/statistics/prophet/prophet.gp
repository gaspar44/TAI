set terminal postscript  color eps 20
set encoding iso_8859_1

#set terminal    gnuplot recommends setting terminal before output
set key top left
set key box

#set yrange [0:120]
#set xrange [0.1:1]

set pointsize 3
set grid

set xlabel "Beta [0:1]"
set ylabel "Delivery Ratio ([0:1])"
set output "prophetdelivery.eps"
f(x) = XX
plot  "prophetdelivery.data"    using 1:2 title 'Prophet' ls 5 w points, f(x) title 'Epidemic' w lines

set xlabel "Beta [0:1]"
set ylabel "Latency (seconds)"
set output "prophetlatency.eps"
g(x) = YY
plot  "prophetlatency.data"    using 1:2 title 'Prophet' ls 5 w points, g(x) title 'Epidemic' w lines


