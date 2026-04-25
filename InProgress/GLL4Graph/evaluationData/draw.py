import matplotlib as mp
import os
from os import listdir
from os.path import isfile, join
import matplotlib.pyplot as plt
import numpy as np
import matplotlib.patches as mpatches

labels = []
def add_label(violin, label):
    color = violin["bodies"][0].get_facecolor().flatten()
    labels.append((mpatches.Patch(color=color), label))


def reject_outliers(data, m = 6.5):
    d = np.abs(data - np.median(data))
    mdev = np.median(d)
    s = d/mdev if mdev else np.zeros(len(d))
    return data[s<m]

def read(file_name,convert_time):
    with open(file_name) as file:
        lines = [float(line.rstrip()) / convert_time for line in file]
        return reject_outliers(np.array(lines[:-1]))

def collect_data(files,convert_time):
    return [(file,read(file,convert_time)) for file in files]

def collect_files(dir_name):
    onlyfiles = [join(dir_name, f) for f in listdir(dir_name)  if isfile(join(dir_name, f))]
    return onlyfiles

def get_query_name(file_path):
    return os.path.splitext(os.path.basename(file_path))[0]

def calc_average(grouped_data):
    result = dict()        
    for grammar in grouped_data.keys():
        for chunk in grouped_data[grammar].keys():
            for graph_data in grouped_data[grammar][chunk]:
                graph = graph_data[0]
                data = graph_data[1]
                key = graph + " " + grammar + " " + chunk
                avg = np.mean(data)
                #print(key + " " + repr(avg))
                result[key] = avg
    return result

def calc_speedup(grouped_data, grouped_data2):
    result = {"g1":{"1":[],"10":[],"100":[]}, "g2":{"1":[],"10":[],"100":[]}, "geo":{"1":[],"10":[],"100":[]}}
    for grammar in grouped_data.keys():
        for chunk in grouped_data[grammar].keys():
            for i in range(0, len(grouped_data[grammar][chunk])):
                graph_data = grouped_data[grammar][chunk][i]
                graph = graph_data[0]
                data1 = graph_data[1]
                data2 = grouped_data2[grammar][chunk][i][1]                
                speedup = data1 / data2                
                result[grammar][chunk].append((graph,speedup))
    return result

def regroup_rdf(raw_data):
    result = {"g1":{"1":[],"10":[],"100":[]}, "g2":{"1":[],"10":[],"100":[]}, "geo":{"1":[],"10":[],"100":[]}}
    for graph_data in raw_data:
        graph_name = graph_data[0]
        for query_data in graph_data[1]:
            #query_full_name = get_query_name(query_data[0]).split('_')
            #grammar = query_full_name[0]
            #chunk_size = query_full_name[1]
            query_full_name = get_query_name(query_data[0]).split('_')
            grammar = query_full_name[-4]
            chunk_size = query_full_name[-1]
            result[grammar][chunk_size].append((graph_name,query_data[1]))
    return result

def regroup_rdf_avg(raw_data):
    #result = {"g1":{"1":[],"10":[],"100":[]}, "g2":{"1":[],"10":[],"100":[]}, "geo":{"1":[],"10":[],"100":[]}}
    result = {"reg1":{"1":[],"10":[],"100":[]}, "reg2":{"1":[],"10":[],"100":[]}, "reg3":{"1":[],"10":[],"100":[]}, "reg4":{"1":[],"10":[],"100":[]}}
    for graph_data in raw_data:
        graph_name = graph_data[0]
        for query_data in graph_data[1]:
            query_full_name = get_query_name(query_data[0]).split('_')
            grammar = query_full_name[0]
            chunk_size = query_full_name[1]
            result[grammar][chunk_size].append((graph_name,query_data[1]))
            #query_full_name = get_query_name(query_data[0]).split('_')
            #grammar = query_full_name[-4]
            #chunk_size = query_full_name[-1]
            #result[grammar][chunk_size].append((graph_name,np.mean(query_data[1])))
    return result

graphs = ["pathways","core","enzyme","eclass","go", "geospecies", "taxonomy"]

raw_data_rpq_native = [ (graph,collect_data(collect_files('rpq/native_rpq/' + graph + '/'), 10**9)) for graph in graphs if os.path.exists('rpq/native_rpq/' + graph + '/')]
#[ (graph,collect_data(collect_files('results/' + graph + '/'), 10**6)) for graph in graphs]

#grouped_data_neo4j = regroup_rdf(raw_data_new4j)

grouped_data_native = regroup_rdf_avg(raw_data_rpq_native)

raw_data_rpq_rsm = [ (graph,collect_data(collect_files('rpq/rsm_rpq/' + graph + '/'), 10**9)) for graph in graphs  if os.path.exists('rpq/rsm_rpq/' + graph + '/')]
#[ (graph,collect_data(collect_files('result_redis/' + graph + '/'), 1)) for graph in graphs]

#grouped_data_redis = regroup_rdf(raw_data_redis)
grouped_data_rsm = regroup_rdf_avg(raw_data_rpq_rsm)

fig, axs = plt.subplots()
plt.yscale("log")
plt.xlabel("Graph")
plt.ylabel("Query evaluation time (ms)")

grammar = "reg4"

line_1_neo = axs.violinplot(list(zip(*grouped_data_native[grammar]["1"]))[1],
                        showmeans=False,
                        showmedians=True)
add_label(line_1_neo, "Native, n = 1")

line_10_neo = axs.violinplot(list(zip(*grouped_data_native[grammar]["10"]))[1],
                         showmeans=False,
                         showmedians=True)
add_label(line_10_neo, "Native, n = 10")                         

line_100_neo = axs.violinplot(list(zip(*grouped_data_native[grammar]["100"]))[1],
                          showmeans=False,
                          showmedians=True)
add_label(line_100_neo, "Native, n = 100")  

line_1_redis = axs.violinplot(list(zip(*grouped_data_rsm[grammar]["1"]))[1],
                        showmeans=False,
                        showmedians=True)
add_label(line_1_redis, "RSM, n = 1")

line_10_redis = axs.violinplot(list(zip(*grouped_data_rsm[grammar]["10"]))[1],
                         showmeans=False,
                         showmedians=True)
add_label(line_10_redis, "RSM, n = 10")                         


line_100_redis = axs.violinplot(list(zip(*grouped_data_rsm[grammar]["100"]))[1],
                          showmeans=False,
                          showmedians=True)
add_label(line_100_redis, "RSM, n = 100")                          

plt.xticks(rotation=45)

axs.set_xticks([y + 1 for y in range(len(graphs))],
                      labels=graphs)

plt.legend(*zip(*labels), loc=2)

fig.autofmt_xdate()                      

plt.savefig(grammar + '_rpq_result.pdf')

"""
graphs = ["pathways","core","enzyme","geospecies","eclass","taxonomy","go","go_hierarchy"]

raw_data_new4j = [ (graph,collect_data(collect_files('kotgll_results/cfg_no_sppf/' + graph + '/'), 10**9)) for graph in graphs]
#[ (graph,collect_data(collect_files('results/' + graph + '/'), 10**6)) for graph in graphs]

#grouped_data_neo4j = regroup_rdf(raw_data_new4j)

grouped_cfg = regroup_rdf_avg(raw_data_new4j)

raw_data_redis = [ (graph,collect_data(collect_files('kotgll_results/rsm_no_sppf/' + graph + '/'), 10**9)) for graph in graphs]
#[ (graph,collect_data(collect_files('result_redis/' + graph + '/'), 1)) for graph in graphs]

#grouped_data_redis = regroup_rdf(raw_data_redis)
grouped_rsm = regroup_rdf_avg(raw_data_redis)
speedup = calc_speedup(grouped_cfg, grouped_rsm)

fig, axs = plt.subplots()
#plt.yscale("log")
plt.xlabel("Graph")
plt.ylabel("Relative speedup (cfg/rsm)")
grammar = "g1"

to_draw = zip(*speedup[grammar]["1"])

#print(*to_draw)

plt.plot(*to_draw, marker='v',linestyle="",label="n = 1")
plt.plot(*zip(*speedup[grammar]["10"]), marker='o',linestyle="",label="n = 10")
plt.plot(*zip(*speedup[grammar]["100"]), marker='s',linestyle="",label="n = 100")


plt.xticks(rotation=45)

axs.set_xticks([y for y in range(len(graphs))],
                      labels=graphs)

#plt.legend(loc=1)
plt.legend(loc=4)

plt.axhline(y=1.0, color='r', linestyle='-')

fig.autofmt_xdate()                      

plt.savefig(grammar + '_kotgll_result.pdf')
"""

"""
fig, axs = plt.subplots()
plt.yscale("log")
plt.xlabel("Graph")
plt.ylabel("Query evaluation time (ms)")

grammar = "g2"

line_1_neo = axs.violinplot(list(zip(*grouped_data_neo4j[grammar]["1"]))[1],
                        showmeans=False,
                        showmedians=True)
add_label(line_1_neo, "CFG, n = 1")

line_10_neo = axs.violinplot(list(zip(*grouped_data_neo4j[grammar]["10"]))[1],
                         showmeans=False,
                         showmedians=True)
add_label(line_10_neo, "CFG, n = 10")                         

line_100_neo = axs.violinplot(list(zip(*grouped_data_neo4j[grammar]["100"]))[1],
                          showmeans=False,
                          showmedians=True)
add_label(line_100_neo, "CFG, n = 100")  

line_1_redis = axs.violinplot(list(zip(*grouped_data_redis[grammar]["1"]))[1],
                        showmeans=False,
                        showmedians=True)
add_label(line_1_redis, "RSM, n = 1")

line_10_redis = axs.violinplot(list(zip(*grouped_data_redis[grammar]["10"]))[1],
                         showmeans=False,
                         showmedians=True)
add_label(line_10_redis, "RSM, n = 10")                         


line_100_redis = axs.violinplot(list(zip(*grouped_data_redis[grammar]["100"]))[1],
                          showmeans=False,
                          showmedians=True)
add_label(line_100_redis, "RSM, n = 100")                          

plt.xticks(rotation=45)

axs.set_xticks([y + 1 for y in range(len(graphs))],
                      labels=graphs)

plt.legend(*zip(*labels), loc=2)

fig.autofmt_xdate()                      

plt.savefig(grammar + '_kotgll_result.pdf')
"""

#avg_cfg = calc_average(grouped_data_neo4j)
#print('=================')
#avg_rsm = calc_average(grouped_data_redis)