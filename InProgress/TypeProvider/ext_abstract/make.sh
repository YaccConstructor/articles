# pdflatex ext-abstract.tex
bibtex ext-abstract
pdflatex --shell-escape ext-abstract.tex
pdflatex ext-abstract.tex

open ext-abstract.pdf &
