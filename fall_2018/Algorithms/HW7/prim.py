class node:
    def __init__(name, edge_list=None):
        self.name=name
        if edge_list is None: edge_list = list()
        self.edge_list = edge_list()

class edge:
    def __init__(end_node, weight):
        self.end_node = end_node
        self.weight = weight

class directedGraph:
    def __init__(node_list=None, edge_list=None):
        if node_list is None: node_list=list()
        if edge_list is None: edge_list=None
        self.node_list = node_list
        self.edge_list = edge_list

    def add_node(edge_list):
        self.node_list.append(node(name=str(size(self.node_list)),
                                   edge_list=edge_list))
    def add_edge(from_node_name, to_node_name, weight):
        
