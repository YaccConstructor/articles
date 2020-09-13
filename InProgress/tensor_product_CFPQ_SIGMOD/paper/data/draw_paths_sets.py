import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import scipy.stats 
import statistics
import math

#styles = [['o','r'],['v','g'],['X','b'],['s','y'],['^','k'],['d','m']]
styles = [['o','g'],['o','r'],['o','b'],['o','m'],['o','k'],['o','y']]

df = pd.read_csv('mappingbased_properties_en_path.csv')[['grammar','time','count_path','max_length']].reindex(columns=['grammar','count_path','time','max_length'])

fig = plt.figure()

#fig, axes = plt.subplots(nrows=2, ncols=2, figsize=(6, 4))
fig, ax = plt.subplots()
#plt.yscale('log')
#plt.xscale('log')

for i, row in df.iterrows():
   x =  2 ** (row['count_path'] + 1)
   df.at[i,'count_path'] = x 
rng = [i for i in range(10)]+[i*50 for i in range(20)]+[i*20 for i in range(20,60)]+[i for i in range(600,1250)]
#data2 = df.loc[lambda dfi: dfi['max_length'].isin(rng), :].groupby(['grammar']) 
data2 = df.groupby(['grammar'])

i = 0

for group in data2:
    #axs = axes[int (i/2)][int (i%2)]
    g = group[1].sample(frac=0.002, replace=True, random_state=1)
    print(len(g))
    if i  == 1: #len(group[1]) > 3000 :       
        scatter = ax.scatter('max_length', 'time', s='count_path', data=g, alpha=0.6,  facecolors='none', 
       	            edgecolors = styles[i][1])
    i = i + 1

#plt.legend()

kw = dict(prop="sizes",  color=scatter.cmap(0.7), fmt="$ {x:.2f}",
          func=lambda s: (np.log2(s)-1))
legend2 = ax.legend(*scatter.legend_elements(**kw),
                    loc="lower right", title="Price")


plt.savefig('ddd.pdf')
#plt.show()