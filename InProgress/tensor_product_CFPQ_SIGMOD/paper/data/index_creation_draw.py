import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import scipy.stats 
9_5

#graphs = ["LUBM1.9M_stat.csv","LUBM1.5M_stat.csv","LUBM100_stat.csv","proteomes_stat.csv","uniprotkb_archea_asgard_group_1935183_0_stat.csv"]
#graphs = ["proteomes_stat.csv","uniprotkb_archea_asgard_group_1935183_0_stat.csv"]

graphs = ["LUBM100_stat.csv","LUBM300_stat.csv","LUBM500_stat.csv","LUBM1M_stat.csv","LUBM1.5M_stat.csv","LUBM1.9M_stat.csv"]

styles = [['o','r'],['v','g'],['X','b'],['s','y'],['^','k'],['d','m']]

q_order=['q_1','q_2','q_3',
         'q_4_2','q_4_3','q_4_4','q_4_5',
         'q_5','q_6','q_7','q_8',
         'q_9_2','q_9_3','q_9_4','q_9_5',
         'q_10_2','q_10_3','q_10_4','q_10_5',
         'q_11_2','q_11_3','q_11_4','q_11_5',
         'q_12','q_13','q_14','q_15','q_16']

dfs = [[g[:-9],pd.read_csv(g)[['grammar','mean']]] for g in graphs]

for df in dfs:
	for i, row in df[1].iterrows():
		x = row['grammar'][:-2].replace('q_','q').replace('q','q_')
		df[1].at[i,'grammar'] = x
	#df[1].set_index('grammar')


#grouped_data = full_data.groupby(['grammar'])

fig = plt.figure()
#plt.yscale('log')
i = 0
print(len(dfs))
for df in dfs:
	#df[1].groupby(['grammar'])
	#df[1].reindex(q_order)
	df[1]['grammar']=pd.Categorical(df[1]['grammar'],categories=q_order)
	df[1]=df[1].sort_values(['grammar'])
	print(df[1])
	plt.scatter(df[1]['grammar'], df[1]['mean'], label=df[0], marker = styles[i][0], facecolors='none', edgecolors = styles[i][1])
	i = i + 1

axs = plt.axes()
leg = axs.legend();
#full_data.plot(kind='scatter',x='grammar',y='mean',color='red')
#full_data.plot(kind='scatter',x='grammar',y='mean',color='green')
#axs.plot(full_data)
#axs.set_title(d[0])


# adding horizontal grid lines
axs.yaxis.grid(True)
plt.xticks(rotation=60, fontsize=8)
#axs.set_xticks([y + 1 for y in range(len(d[1]))])
axs.set_xlabel('Query')
axs.set_ylabel('Time in seconds')
fig.tight_layout()
plt.savefig("LUBM_all.pdf")
plt.show()
