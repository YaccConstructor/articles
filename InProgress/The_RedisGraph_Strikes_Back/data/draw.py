import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np
import pandas as pd
import scipy.stats 

def reject_outliers(data, m=1.2):
    return data[abs(data - np.mean(data)) < m * np.std(data)]

def draw(input_file, p=0):

	labels = []
	def add_label(violin, label):
	    color = violin["bodies"][0].get_facecolor().flatten()
	    labels.append((mpatches.Patch(color=color), label))


	plt.ioff()

	data = pd.read_csv(input_file).groupby(['grammar','algo'])
	
	fig, axes = plt.subplots(nrows=3, ncols=1, figsize=(6, 4))

	legend_rename = {'Brute':'Naive', 'Opt':'Cache'}

	i = 0
	for name, group in data:
		data = group[['chunk_size','chunk_time']].groupby(['chunk_size'])
		if p > 0 : data = list(data)[:p]
		r = [x for x in [[n,reject_outliers(d['chunk_time'])] for n,d in data] if len(x[1]) > 0 ]
		d = list(zip(*r))
		axs = axes[int (i/2)]
		if i%2 == 0 : labels = []
		add_label(axs.violinplot(d[1],
				       showmeans=False,
				       showmedians=True), f'{legend_rename[name[1][16:]]} ({name[0]})')

		axs.set_xticks(range(1,len(d[0])+1))
		axs.set_xticklabels(d[0])
		
		i = i + 1
		axs.yaxis.grid(True)

		leg = axs.legend(*zip(*labels), loc=2);
    
	axs.set_xlabel('Chunk size')
	
	fig.text(0.004, 0.5, 'Time in sec', va='center', rotation='vertical')

	fig.tight_layout()

	f_name = f'{input_file[:-4]}'
	if p > 0 : f_name = f'{f_name}_{p}'
	plt.savefig(f'{f_name}.pdf')
	plt.close(fig)


def draw_redis(input_file):

	plt.ioff()

	input_data = pd.read_csv(input_file)

	fig, axes = plt.subplots(nrows=1, ncols=1, figsize=(6, 4))

	
	data=input_data[['chunk_size','chunk_time']].groupby(['chunk_size'])
	r = [x for x in [[n,reject_outliers(d['chunk_time'])] for n,d in data] if len(x[1]) > 0 ]
	d = list(zip(*r))
	axs = axes
	axs.violinplot(d[1], showmeans=False, showmedians=True)

	axs.set_xticks(range(1,len(d[0])+1))
	axs.set_xticklabels(d[0])
	
	axs.yaxis.grid(True)

	leg = axs.legend([input_data['grammar'][0]], loc=2);

	axs.set_xlabel('Chunk size')
	
	fig.text(0.004, 0.5, 'Time in sec', va='center', rotation='vertical')

	fig.tight_layout()

	plt.savefig(f'{input_file[:-4]}.pdf')
	plt.close(fig)


def draw_redis_memory(input_file, p=0):

	plt.ioff()

	input_data = pd.read_csv(input_file)

	fig, axes = plt.subplots(nrows=1, ncols=1, figsize=(6, 4))

	data = input_data[['chunk_size','chunk_mem_mb']][input_data.apply(lambda x: x['chunk_mem_mb'] > 0, axis=1)].groupby(['chunk_size'])
	r = [x for x in [[n,reject_outliers(d['chunk_mem_mb'])] for n,d in data] if len(x[1]) > 0 ]
	d = list(zip(*r))
	axs = axes
	axs.violinplot(d[1], showmeans=False, showmedians=True)

	axs.set_xticks(range(1,len(d[0])+1))
	axs.set_xticklabels(d[0])
	
	axs.yaxis.grid(True)

	leg = axs.legend([input_data['grammar'][0]], loc=2);

	axs.set_xlabel('Chunk size')
	
	fig.text(0.004, 0.5, 'Memory in Mb', va='center', rotation='vertical')

	fig.tight_layout()

	plt.savefig(f'{input_file[:-4]}.pdf')
	plt.close(fig)


files_to_draw = [f'raw/{x}.csv' for x in ['core','eclass_514en','enzyme','geospecies','go','gohierarchy','pathways']]
files_to_draw_redis = [f'raw_redis/{x}.csv' for x in ['core','eclass_514en','enzyme','geospecies','go','gohierarchy','pathways']]
files_to_draw_redis_memory = [f'raw_memory/{x}.csv' for x in ['core','eclass_514en','enzyme','geospecies','go','pathways']]


for f in files_to_draw: draw(f,4)