import pandas as pd
from matplotlib import pyplot as plt
from os import listdir
from os.path import isfile, join
from pathlib import Path
import csv
import itertools

dir_to_draw = 'MILK-V'
#dir_to_draw = 'Lenovo-T480'
#dir_to_draw = 'zenbook_iris'


#files_to_compare = [('openblas','brahma_poclcpu'),('clblast_poclcpu','brahma_poclcpu'),('clblast_nvidia','brahma_nvidia'),('clblast_intelgpu','brahma_intelgpu')]
#files_to_compare = [('openblas','brahma_poclcpu'),('clblast_intelgpu','brahma_intelgpu'),('clblast_poclcpu','brahma_poclcpu'),('openblas','brahma_intelgpu')]
files_to_compare = [('openblas','brahma_poclcpu'),('clblast_img','brahma_img'),('clblast_poclcpu','brahma_poclcpu')]
markers = itertools.cycle(('+', 'v', '^', 's', 'd', 'o', '*', 'x', '>', '<'))

plt.rcParams["figure.autolayout"] = True

for file in files_to_compare:
    x = []
    y = []
    with open(join(dir_to_draw, file[0] + '.csv'),'r') as csv1_to_draw:
        with open(join(dir_to_draw, file[1] + '.csv'),'r') as csv2_to_draw:
            lines1 = csv.reader(csv1_to_draw, delimiter=',')
            next(lines1)
            lines2 = csv.reader(csv2_to_draw, delimiter=',')
            next(lines2)
            for row in lines1:
                y2 = float (next(lines2)[1])
                x.append(row[0])
                y.append(float(row[1])/y2)
            label =  Path(file[0]).stem + ' / ' + Path(file[1]).stem
            plt.plot(x, y, label=label, marker=next(markers))
    
plt.minorticks_on()
plt.xticks(rotation = 25)
plt.xlabel('Matrix size (N)')
plt.ylabel('Relative speedup')
plt.legend()
plt.grid(axis='y',which='minor', alpha=0.2)
plt.grid(axis='y',which='major', alpha=0.5)
plt.savefig(dir_to_draw + '_rel.pdf')
plt.savefig(dir_to_draw + '_rel.png')
plt.show()

