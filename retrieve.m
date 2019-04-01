%NPC 234 N87

function [Mw,Mv,B]=retrieve(root,tree,Dead)
pos=find(Dead==0);
polynum=0;
totalmass=0;
Mw=0;
Mv=0;
D=0;
T=0;
L=0;
for i=1:length(pos)
    if root(pos(i))~=0
        polynum=polynum+1;
        totalmass=totalmass+(root(pos(i))-1)*234+321;
    end
end
for i=1:length(pos)
    Mw=Mw+((root(pos(i))-1)*234+321)/totalmass;
end
Mv=totalmass/polynum;

for i=1:length(pos)
    [a,b,c]=Ds(root,tree,pos(i),0);
    D=D+a;
    T=T+b;
    L=L+c;
end
B=(D+T)/(D+T+L);
end