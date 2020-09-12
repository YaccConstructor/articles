import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import scipy.stats 
import statistics
import math

def reject_outliers(data, m=1.1):
    return data[abs(data - np.mean(data)) < m * np.std(data)]


df = pd.read_csv('geospecies_path.csv')[['grammar','time','length']].loc[lambda dfi: dfi['grammar'] == 'geo'][['time','length']].reindex(columns=['length','time']).groupby(['length'])
#.reindex(columns=['grammar','count_path','time','max_length'])

fig = plt.figure()
axs = plt.axes()
plt.ticklabel_format(axis="y", style="sci", scilimits=(0,0))

data = [[n,reject_outliers(g['time'])] for n,g in df]
res = list(zip(*data))
axs.violinplot(res[1],
               positions=res[0],
               showmeans=False,
               showmedians=True)

axs.yaxis.grid(True)
axs.set_xticks(res[0])
axs.set_xlabel('Length of path (nuber of edges)')
axs.set_ylabel('Time in seconds')
plt.savefig("geo_path_matrix.pdf")

plt.show()

plt.close(fig)