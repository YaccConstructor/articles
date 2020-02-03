set datafile separator ','

set terminal pdf
set output 'enzime_narrowerTr_path_per_length.pdf'

set logscale y 2

set style data histogram
set boxwidth 0.9 relative
set style fill solid
set style histogram cluster gap 1

set ylabel 'Number of paths' # label for the Y axis
set xlabel 'Length of path (edges)' # label for the X axis

unset key

set style line 100 lt 1 lc rgb "grey" lw 0.5 # linestyle for the grid
set grid ls 100 # enable grid with specific linestyle

plot 'enzime_narrowerTr_path_per_length.csv' u 2:xtic(1) #ls 4
# using 1:2:xtic(1)# with boxes
