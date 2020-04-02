set datafile separator ','

set terminal pdf
set output 'mem_per_paths_BT.pdf'

set ylabel 'Used memory (MB)' # label for the Y axis
set xlabel 'Query result size (number of unique paths)' # label for the X axis

set format y "2^%L"

set logscale x 10

set logscale y 2

f_enzime_BT(x) = a1*x + b1

fit f_enzime_BT(x) 'enzime/enzime_BT_sg_mem_per_paths.csv' using 1:2 via a1,b1

f_geo_BT(x) = a2*x + b2

fit f_geo_BT(x) 'geo/geo_BT_sg_mem_per_paths.csv' using 1:2 via a2,b2

set key left top

set style line 100 lt 1 lc rgb "grey" lw 0.5 # linestyle for the grid
set grid ls 100 # enable grid with specific linestyle

plot 'enzime/enzime_BT_sg_stat_mem_per_paths.csv' using 1:6 pt 4 linecolor black title "Enzyme Q_2",  f_enzime_BT(x) notitle, 'geo/geo_BT_sg_stat_mem_per_paths.csv' using 1:6 pt 2 linecolor rgb "red" title "Geospecies Q_2", f_geo_BT(x) notitle  


#plot 'enzime/enzime_BT_sg_stat_mem_per_paths.csv' using 1:2:3:4:5 with candlesticks whiskerbars 0.5 lw 0.5 title "Enzime", '' using 1:6:6:6:6 with candlesticks notitle lw 0.5 lc rgb "#008800",  f_enzime_BT(x), 'geo/geo_BT_sg_stat_mem_per_paths.csv' using 1:2:3:4:5 with candlesticks whiskerbars 0.5 lw 0.5 title "Geo", '' using 1:6:6:6:6 with candlesticks notitle lw 0.5 lc rgb "#660000" #,  f_geo_BT(x)  
