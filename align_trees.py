import dendropy

def align_tree_tips(tree, total_length=13):
    # Get the maximum depth of the tree
    max_depth = max(leaf.distance_from_root() for leaf in tree.leaf_node_iter())
    
    # Adjust all internal branches
    for node in tree.preorder_node_iter():
        if not node.is_leaf():
            node.edge.length = node.edge.length * total_length / max_depth

    # Set all terminal branches to reach the total_length
    for leaf in tree.leaf_node_iter():
        current_depth = leaf.distance_from_root()
        leaf.edge.length = total_length - current_depth

    return tree

# Load all trees
trees = dendropy.TreeList.get(path="processed_trees.nwk", schema="newick")

# Align tips for each tree
aligned_trees = dendropy.TreeList()
for tree in trees:
    aligned_tree = align_tree_tips(tree)
    aligned_trees.append(aligned_tree)

# Write the aligned trees to a new NEXUS file
aligned_trees.write(path="aligned_trees.nex", schema="nexus")

print("Created 'aligned_trees.nex' with all tree tips aligned at distance 13 from the root.")
