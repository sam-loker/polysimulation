function[tree,leaf,root,cnt]=duplicate(tree,leaf,root,cnt)
l=size(root,2);
for i=l+1:l+l
    root(i)=root(i-l);
    leaf(i)=leaf(i-l);
    tree(i)=tree(i-l);
end
for i=1:cnt-2*l
    tree(cnt+i)=tree(2*i+i);
end
cnt=cnt+i
end