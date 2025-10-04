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


files = [f for f in listdir(dir_to_draw) if isfile(join(dir_to_draw, f))]
markers = itertools.cycle(('+', 'v', '^', 's', 'd', 'o', '*', 'x', '>', '<'))

plt.rcParams["figure.autolayout"] = True

for file in files:
    x = []
    y = []
    with open(join(dir_to_draw,file),'r') as csv_to_draw:
        lines = csv.reader(csv_to_draw, delimiter=',')
        next(lines)
        for row in lines:
            x.append(row[0])
            y.append(float(row[1])/1000)
        plt.plot(x, y, label=Path(file).stem, marker=next(markers))
    
plt.minorticks_on()
plt.xticks(rotation = 25)
plt.xlabel('Matrix size (N)')
plt.ylabel('Time (sec)')
plt.legend()
plt.grid(axis='y',which='minor', alpha=0.2)
plt.grid(axis='y',which='major', alpha=0.5)
plt.savefig(dir_to_draw + '.pdf')
plt.savefig(dir_to_draw + '.png')
plt.show()

