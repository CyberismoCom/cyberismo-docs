
node(node1).
attr(node, node1, label, "Node 1").

node(node2).
attr(node, node2, label, "Node 2").

edge((node1, node2, 1), default).
attr(edge, (node1, node2, 1), label, "Relationship").

node(node3, anotherGraph).