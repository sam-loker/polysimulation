function[root,leaf,tree,Dead,cnt]=Branch(root,leaf,tree,Dead,cnt,roota,rootb,tmp_1)
num=0;
while num==0
    num=unidrnd(tmp_1);
    tmp=roota;
    while num>=tree(tmp).v
        if num==tree(tmp).v&&tree(tmp).ls==0
            break;
        end;
        num=num-tree(tmp).v;
        tmp=tree(tmp).ls;
    end
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