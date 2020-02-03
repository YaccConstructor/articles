set datafile separator ','

set terminal pdf
set output 'enzime_narrowerTr_mem_per_paths.pdf'

set ylabel 'Used memory (kB)' # label for the Y axis
set xlabel 'Query result size (number of unique paths)' # label for the X axis

unset key

set style line 100 lt 1 lc rgb "grey" lw 0.5 # linestyle for the grid
set grid ls 100 # enable grid with specific linestyle

plot 'enzime_narrowerTr_mem_per_paths.csv'
