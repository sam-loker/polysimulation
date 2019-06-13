function  [root,tree]=AddNPC(root,leaf,tree,roota)
root(roota)=root(roota)+10;
tree(leaf(roota)).v=tree(leaf(roota)).v+10;
end