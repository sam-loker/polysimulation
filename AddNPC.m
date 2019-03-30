function  [root,tree]=AddNPC(root,leaf,tree,roota)
root(roota)=root(roota)+1;
tree(leaf(roota)).v=tree(leaf(roota)).v+1;
end