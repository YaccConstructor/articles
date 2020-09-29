import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np
import pandas as pd
import scipy.stats 

def reject_outliers(data, m=1.2):
    return data[abs(data - np.mean(data)) < m * np.std(data)]



files_to_draw = [f'raw/{x}.csv' for x in ['core','eclass_514en','enzyme','geospecies','go','gohierarchy','pathways']]
files_to_draw_redis = [f'raw_redis/{x}.csv' for x in ['core','eclass_514en','enzyme','geospecies','go','gohierarchy','pathways']]


def draw(input_file, p):

	labels = []
	def add_label(violin, label):
	    color = violin["bodies"][0].get_facecolor().flatten()
	    labels.append((mpatches.Patch(color=color), label))


	plt.ioff()

	data = pd.read_csv(input_file).groupby(['grammar','algo'])
	
	fig, axes = plt.subplots(nrows=3, ncols=1, figsize=(6, 4))

	#plt.xscale('log')
	#plt.yscale('log')

	i = 0
	for name, group in data:
		#print(name)
		data=group[['chunk_size','chunk_time']].groupby(['chunk_size'])
		#print(data)
		r = [x for x in [[n,reject_outliers(d['chunk_time'])] for n,d in data] if len(x[1]) > 0 ]
		d = list(zip(*r))
		#print(r)
		axs = axes[int (i/2)]
		#axs.ticklabel_format(axis='y',style='sci')
		#axs.set_yscale('log')
		if i%2 == 0 : labels = []
		add_label(axs.violinplot(d[1],
				       showmeans=False,
				       showmedians=True), f'{name[1][16:]} ({name[0]})')

		axs.set_xticks(range(1,len(d[0])+1))
		axs.set_xticklabels(d[0])
		
		i = i + 1
		#axs.set_xlabel('Chunk size')
		#axs.set_ylabel('Time in sec')
		axs.yaxis.grid(True)

		leg = axs.legend(*zip(*labels), loc=2);
    
	axs.set_xlabel('Chunk size')
	
	fig.text(0.004, 0.5, 'Time in sec', va='center', rotation='vertical')

	fig.tight_layout()

	plt.savefig(f'{input_file[:-4]}.pdf')
	plt.close(fig)
	#plt.show()


def draw_redis(input_file, p):

	labels = []
	def add_label(violin, label):
	    color = violin["bodies"][0].get_facecolor().flatten()
	    labels.append((mpatches.Patch(color=color), label))


	plt.ioff()

	input_data = pd.read_csv(input_file)

	fig, axes = plt.subplots(nrows=1, ncols=1, figsize=(6, 4))

	
	data=input_data[['chunk_size','chunk_time']].groupby(['chunk_size'])
	r = [x for x in [[n,reject_outliers(d['chunk_time'])] for n,d in data] if len(x[1]) > 0 ]
	d = list(zip(*r))
	axs = axes
#	if i%2 == 0 : labels = []
	axs.violinplot(d[1], showmeans=False, showmedians=True)

	axs.set_xticks(range(1,len(d[0])+1))
	axs.set_xticklabels(d[0])
	
	#axs.set_xlabel('Chunk size')
	#axs.set_ylabel('Time in sec')
	axs.yaxis.grid(True)

	leg = axs.legend([input_data['grammar'][0]], loc=2);

	axs.set_xlabel('Chunk size')
	
	fig.text(0.004, 0.5, 'Time in sec', va='center', rotation='vertical')

	fig.tight_layout()

	plt.savefig(f'{input_file[:-4]}.pdf')
	plt.close(fig)
	#plt.show()


for f in files_to_draw_redis: draw_redis(f,10)