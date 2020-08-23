set datafile separator ','

set terminal pdf
set output 'time_per_paths_SCO.pdf'

set ylabel 'Execution time (ms)' # label for the Y axis
set xlabel 'Query result size (number of unique paths)' # label for the X axis

set format y "10^%L"

set logscale x 10

set logscale y 10

f_enzime_SCO(x) = a1*x + b1

fit f_enzime_SCO(x) 'enzime/enzime_SCO_sg_time_per_paths.csv' using 1:2 via a1,b1

f_geo_SCO(x) = a2*x + b2

fit f_geo_SCO(x) 'geo/geo_SCO_sg_time_per_paths.csv' using 1:2 via a2,b2

set key left top

set style line 100 lt 1 lc rgb "grey" lw 0.5 # linestyle for the grid
set grid ls 100 # enable grid with specific linestyle

plot 'enzime/enzime_SCO_sg_stat_time_per_paths.csv' using 1:6 pt 4 linecolor black title "Enzyme Q_1",  f_enzime_SCO(x) notitle, 'geo/geo_SCO_sg_stat_time_per_paths.csv' using 1:6 pt 2 linecolor rgb "red" title "Geospecies Q_1",  f_geo_SCO(x) notitle 


#plot 'enzime/enzime_SCO_sg_stat_time_per_paths.csv' using 1:2:3:4:5 with candlesticks whiskerbars 0.5 lw 0.5 title "x", '' using 1:6:6:6:6 with candlesticks notitle lw 0.5 lc rgb "#008800",  f_enzime_SCO(x), 'geo/geo_SCO_sg_stat_time_per_paths.csv' using 1:2:3:4:5 with candlesticks whiskerbars 0.5 lw 0.5 title "x", '' using 1:6:6:6:6 with candlesticks notitle lw 0.5 lc rgb "#008800", f_geo_SCO(x)

