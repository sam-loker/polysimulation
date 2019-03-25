function  [root,tree]=AddNPC(root,leaf,tree,roota)
root(roota)=root(roota)+1;
tree(leaf(roota))=tree(leaf(roota))+1;
