unset label
set xlabel "Number of basic blocks (m)."
set ylabel "Time in milliseconds."
set grid

set logscale y
set yrange [9:*]
set xrange [0:55]

set terminal post eps enhanced color
set output 'all.eps'

plot 'test_out1.plot'  title 'n=1', \
     'test_out2.plot'  title 'n=2', \
     'test_out5.plot'  title 'n=5', \
     'test_out10.plot'  title 'n=10'

set out

