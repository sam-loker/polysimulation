function [D,T,L]=Ds(root,tree,Node,Tag)
D=0;
T=0;
L=0;
DD=0;
TT=0;
LL=0;
if Node==0
D=0;
T=0;
L=0;
else
if Tag==0
    DD=tree(Node).v;
else
    LL=tree(Node).v;
end
if tree(Node).ls==0&&Tag==0
    TT=1;
end
if tree(Node).f==0&&Tag==1
    TT=1;
end
if(Tag==1)
    [a,b,c]=Ds(root,tree,tree(Node).f,Tag);
    [d,e,f]=Ds(root,tree,tree(Node).rs,1);
    D=a+d+DD;
    T=b+e+TT;
    L=c+f+LL;
end
if(Tag==0)
    [a,b,c]=Ds(root,tree,tree(Node).ls,Tag);
    [d,e,f]=Ds(root,tree,tree(Node).rs,1);
    D=a+d+DD;
    T=b+e+TT;
    L=c+f+LL;
end
end
end

