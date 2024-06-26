set datafile separator ','

set terminal pdf
set output 'time_per_paths_NT.pdf'

set ylabel 'Execution time (ms)' # label for the Y axis
set xlabel 'Query result size (number of unique paths)' # label for the X axis

set format y "10^%L"

set logscale x 10

set logscale y 10

f_enzime_NT(x) = a1*x + b1

fit f_enzime_NT(x) 'enzime/enzime_NT_sg_time_per_paths.csv' using 1:2 via a1,b1

f_geo_NT(x) = a2*x + b2

fit f_geo_NT(x) 'geo/geo_NT_sg_time_per_paths.csv' using 1:2 via a2,b2

set key left top

set style line 100 lt 1 lc rgb "grey" lw 0.5 # linestyle for the grid
set grid ls 100 # enable grid with specific linestyle

plot 'enzime/enzime_NT_sg_stat_time_per_paths.csv' using 1:6 pt 4 linecolor black title "Enzyme Q_3",  f_enzime_NT(x) notitle, 'geo/geo_NT_sg_stat_time_per_paths.csv' using 1:6 pt 2 linecolor rgb "red" title "Geospecies Q_3", f_geo_NT(x) notitle
