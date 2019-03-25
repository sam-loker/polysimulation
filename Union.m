function[tree,root,leaf,cnt]= union(tree,root,leaf,cnt,roota,rootb,num)
tmp=roota;
while(num>tree(tmp).v)
    tmp=tmp-tree(tmp).v;
    tmp=tree(tmp).ls;
    num=num-tree(tmp).v;
end
cnt=cnt+1
tree(cnt).f=tmp;
tree(cnt).ls=tree(tmp).ls;
tree(cnt).v=tree(tmp).v-num;
tree(tmp).v=num;
tree(tree(tmp).ls).f=cnt;
tree(tmp).ls=cnt;
tree(cnt).rs=leaf(rootb);
tree(leaf(rootb)).tag=1;
root(roota)=root(roota)+root(rootb);
root(rootb)=0;
if tree(cnt).ls==0
   leaf(roota)=cnt;
end