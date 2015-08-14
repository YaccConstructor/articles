sh pdf2eps.sh 1 big_res
sh pdf2eps.sh 1 paths
sh pdf2eps.sh 1 semantics_example
sh pdf2eps.sh 1 simple_grammar_inpt
sh pdf2eps.sh 1 simple_grammar_items
dot -O -Tpdf simple_sql.dot
pdfcrop "simple_sql.dot.pdf" "simple_sql-temp.pdf"
pdftops -f 1 -l 1 -eps "simple_sql-temp.pdf" "simple_sql.eps"
rm  "simple_sql-temp.pdf"
sh pdf2eps.sh 1 states_example
