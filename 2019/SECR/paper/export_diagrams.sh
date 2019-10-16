#!/bin/bash
for f in diagrams/*.dia
do 
    dia -e $f.png -t png -s 1280x $f
done

mkdir pictures
mv diagrams/*.dia.png pictures/
#for /r %%v in (*.dia.png) do move /y %%v pictures
