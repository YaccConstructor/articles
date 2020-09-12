import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import scipy.stats 
import statistics
import math

def reject_outliers(data, m=1.5):
    return data[abs(data - np.mean(data)) < m * np.std(data)]

file = '../../mappingbased_properties_en_path.csv'
grammar = 'q4_5/8'

#file = 'geospecies_path.csv'
#grammar = 'geospecies_automat'

#df = pd.read_csv(file)[['grammar','time','count_path','max_length']].loc[lambda dfi: dfi['grammar'] == grammar].loc[lambda dfi: dfi['count_path'] == 1].loc[lambda dfi: dfi['max_length'].isin([2,4,6,8,10])][['time','max_length']].reindex(columns=['max_length','time']).groupby(['max_length'])


df = pd.read_csv(file)[['grammar','time','count_path','max_length']].loc[lambda dfi: dfi['grammar'] == grammar].loc[lambda dfi: dfi['count_path'] == 1][['time','max_length']].reindex(columns=['max_length','time']).groupby(['max_length'])


fig = plt.figure()
axs = plt.axes()

data = [[y,x] for y,x in [[n,reject_outliers(g['time'])] for n,g in df] if len(x) > 0]
res = list(zip(*data))
axs.violinplot(res[1],
               positions=res[0],
               showmeans=False,
               showmedians=True)

axs.yaxis.grid(True)
#plt.xticks(res[0], rotation=60, fontsize=8)
#axs.set_xticks(res[0], rotation=60, fontsize=8)
axs.set_xlabel('Length of path (nuber of edges)')
axs.set_ylabel('Time in seconds')
plt.savefig("dbpedia_path_tensor.pdf")

plt.show()

plt.close(fig)