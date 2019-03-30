function [D,T,L]=Ds(root,Node,Tag);
if Node==0
    [D,T,L]=0;
else
if Tag==0
    DD=root(Node);
else
    LL=root(Node);
end
if root(Node).ls==0&&Tag==0
    TT=1;
end
if root(Node).f==0&&Tag==1
    TT=1;
end
if(Tag==1)
    [D,T,L]=[DD,TT,LL]+Ds(root,root(Node).f,Tag)+Ds(root,root(Node).rs,1);
end
if(Tag==0)
    [D,T,L]=[DD,TT,LL]+Ds(root,root(Node).ls,Tag)+Ds(root,root(Node).rs,1);
end
end
end

