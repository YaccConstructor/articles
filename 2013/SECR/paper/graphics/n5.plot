unset label
set xlabel "Number of basic blocks (m)."
set ylabel "Time in milliseconds."
set grid

set nologscale y
set yrange [9:*]
set xrange [0:55]

set terminal post eps enhanced color
set output 'n5.eps'

plot 'test_out5.plot'  title 'n=5'

set out

