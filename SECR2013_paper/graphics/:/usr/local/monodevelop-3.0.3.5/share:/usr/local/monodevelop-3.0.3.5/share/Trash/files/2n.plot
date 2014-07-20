unset label
set xlabel "Number of test (n)."
set ylabel "Time in milliseconds."
set grid

set nologscale y

set xrange [0:12]
set yrange [0:880]

set terminal  post eps enhanced color
set output '2n.eps'

plot 'test_out2n.plot' with linespoints title 'Nested branches'

set out
