%% Initialization
clear ; close all; clc;
%% Set parameters for simulation
root=zero(20);
%% Struct
leaf=zeros(1,size(root,2))
tree=struct('f',0,'rs',0,'ls',0,'v',0,'tag',0)
cnt=2*size(root,2);
originalNPCnum=20*size(root,2);
NPC_cum=originalNPCnum;
%Initialize each polymer
for i=1:size(root,2)*2
    tree(i).f=0;
    tree(i).rs=0;
    tree(i).ls=0;
    tree(i).v=0;
    tree(i).tag=0;
    root(i)=1;
    leaf(i)=i;
end
NPCadded=1;
Nadded=0;
conversion=0;
Params= zeros(5,20);
ed=1
while conversion<=0.8
    root_num = sum (root~=0);
    if NPC_num+root_num==ceil((originalNPCnum+size(root,2)))/2
        %
        %
    end
    a1;
    a2;
    a0;
    dt;
    r2;
    if a
        reactionType=1;
    else
        reactionType=0;
    end
    %find pos
    pos = find(root);
    randroot=unidrnd(length(pos));
    randnum=unidrnd(tree(pos(randroot)).v)
    if reactionType==NPCadded
        [root,leaf,tree]=AddNPC(root,leaf,tree,pos(randroot));
    end
    if(reactionType==Nadded)
       rootB=unidrnd(length(pos));
       [tree,root,leaf,cnt]=Union(tree,root,leaf,cnt,pos(randroot),pos(rootB),randnum);
    end
    [Mn, Mw, B] = retrieve(polymer, EGDE);
	Params(:,ed) =  [conversion;Mn;Mw;B;t];
    conversion = (originalNPCnum - NPC_num) / originalNPCnum;
    t=t+dt;
end