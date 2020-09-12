import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import scipy.stats 


def reject_outliers(data, m=1.0):
    return data[abs(data - np.mean(data)) < m * np.std(data)]

#file_to_read = "CF/enzyme_path.csv"
file_to_read = "single_path.csv"

full_data = pd.read_csv(file_to_read)[['grammar','mean','length_path']].reindex(columns=['grammar','length_path','mean'])

grouped_by_grammar = full_data.groupby(['grammar'])

ready_to_draw = [[g[0],[(x[0], reject_outliers(x[1]['mean'].values)) for x in g[1].groupby(['length_path'])]] for g in grouped_by_grammar]
	
def draw_file_per_query (ready_to_draw):
    # Turn interactive plotting off
    plt.ioff()
    important_data = [d for d in ready_to_draw if len(d[1]) > 2]
    for d in important_data :
        fig = plt.figure()
        axs = plt.axes()
        res = list(zip(*d[1]))
        print(res[1])
        axs.violinplot(res[1],
        	   positions=res[0],
               showmeans=False,
               showmedians=True)
        #axs.set_title(d[0])


	    # adding horizontal grid lines
        axs.yaxis.grid(True)
        #print(d)
        axs.set_xticks(res[0])
        axs.set_xlabel('Length of path (nuber of edges)')
        axs.set_ylabel('Time in seconds')
        plt.savefig("geo_rpq_single_path/" + d[0].replace('/','_') + ".pdf")
        plt.close(fig)

def draw_all (ready_to_draw):
	fig, axes = plt.subplots(nrows=3, ncols=3, figsize=(6, 4))

	all_data = [x[1] for x in ready_to_draw]

	for i in range(21):
		axs = axes[int (i/7)][int (i%3)]
		axs.violinplot(all_data[i],
			       showmeans=False,
			       showmedians=True)
		axs.set_title('Violin plot')


		# adding horizontal grid lines
		axs.yaxis.grid(True)
		axs.set_xticks([y + 1 for y in range(len(all_data[i]))])
		axs.set_xlabel('Four separate samples')
		axs.set_ylabel('Observed values')

	# add x-tick labels
	#plt.setp(axes, xticks=[y + 1 for y in range(4)],
	#         xticklabels=['l=0', 'l=1', 'l=2', 'l=3'])
	plt.show()

draw_file_per_query(ready_to_draw)
