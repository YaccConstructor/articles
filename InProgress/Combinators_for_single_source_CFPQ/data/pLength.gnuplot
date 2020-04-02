set datafile separator ','

set terminal pdf
set output 'path_per_length.pdf'

set logscale y 10

set format y "10^%L"

set style data histogram
set style fill solid

set ylabel 'Number of paths' # label for the Y axis
set xlabel 'Length of path (edges)' # label for the X axis

set style line 100 lt 1 lc rgb "grey" lw 0.5 # linestyle for the grid
set grid ls 100 # enable grid with specific linestyle

plot 'geo/geo_SCO_sg_path_per_length.csv' u 2:xtic(1) title "geo Q_1", 'geo/geo_NT_sg_path_per_length.csv' u 2:xtic(1) title "geo Q_3", 'geo/geo_BT_sg_path_per_length.csv' u 2:xtic(1) title "geo Q_2", 'enzime/enzime_SCO_sg_path_per_length.csv' u 2:xtic(1) title "enzime Q_1", 'enzime/enzime_NT_sg_path_per_length.csv' u 2:xtic(1) title "enzime Q_3", 'enzime/enzime_BT_sg_path_per_length.csv' u 2:xtic(1) title "enzime Q_2"