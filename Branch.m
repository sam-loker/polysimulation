function[root,leaf,tree,Dead,cnt]=Branch(root,leaf,tree,Dead,cnt,roota,rootb,num)
tmp=roota;
while num>=tree(tmp).v
    num=num-tree(tmp).v;
    tmp=tree(tmp).ls;
    if(num==0)num=num+1;end
end
cnt=cnt+1;
Dead(rootb)=1;
tree(cnt).f=tmp;
tree(cnt).ls=tree(tmp).ls;
tree(cnt).v=tree(tmp).v-num;
tree(tmp).v=num;
if(tree(tmp).ls~=0)
tree(tree(tmp).ls).f=cnt;
end
tree(tmp).ls=cnt;
tree(cnt).rs=leaf(rootb);
tree(leaf(rootb)).tag=1;
root(roota)=root(roota)+root(rootb);
if tree(cnt).ls==0
   leaf(roota)=cnt;
end
end