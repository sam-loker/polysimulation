%% Initialization
clear ; close all; clc;
%% Set initial parameters for simulation
root=zeros(20);
leaf=zeros(1,size(root,2))
tree=struct('f',0,'rs',0,'ls',0,'v',0,'tag',0)
cnt=2*size(root,2);
Dead=zeros(1,size(root,2))
originalNPCnum=20*size(root,2);
NPC_num=originalNPCnum;
NCA_num=0;
AcH_num=1;
Ac_num=0;
k1=1;
k2=1;
k3=1;
k4=1;
k5=1;
k6=1;
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
conversion=0;
Params= zeros(5,20000);
ed=0.8;
while conversion<=ed
    root_num = sum (Dead~=0);
    if NPC_num+NCA_num+root_num==ceil((originalNPCnum+size(root,2)))/2
        duplicate();
    end
    r1=unidrnd(0,1);
    r2=unidrnd(0,1);
    a1=1;
    a2=1;
    a3=1;
    a4=1;
    a5=1;
    a6=1;
    a0=a1+a2+a3+a4+a5+a6;
    dt = -1/a0*log(r1);
    reactType=r2*a0;
    pos = find(Dead==0);
    randroot=unidrnd(length(pos));
    tmp=randroot;
    tmp_1=0;
    while tree(tmp).ls~=0
        tmp_1=tmp_1+tree(tmp).v;
        tmp=tree(tmp).v;
    end
    randnum=unidrnd(tmp_1);
    if reactType>0&&reactType<=a1
        NPC_num=NPC_num-1;
        NCA_num=NCA_num+1;
    end
    if reactType>a1&&reactType<=a2
        Dead(randroot)=1;
        AcH_num=AcH_num-1;
        Ac_num=Ac_num+1;
    end
    if reactType>a2&&reactType<=a3
        posdead=find(Dead);
        Deadroot=unidrnd(length(posdead));
        Dead(Deadroot)=0;
        AcH_num=AcH_num+1;
        Ac_num=Ac_num-1;
    end
    if reactType>a3&&reactType<=a4
        [root,leaf,tree]=AddNPC(root,leaf,tree,pos(randroot));
        NCA_num=NCA_num-1;
    end
    if reactType>a4&&reactType<=a5
        Suicide();
        
    end
    if reactType>a5&&reactType<=a6
       rootB=unidrnd(length(pos));
       [root,leaf,tree,Dead,cnt]=Branch(root,leaf,tree,Dead,cnt,pos(randroot),pos(rootB),randnum);
    end
	Params(:,ed) =  [conversion;Mn;Mw;B;t];
    conversion = (originalNPCnum - NPC_num-NCA_num) / originalNPCnum;
    t=t+dt;
end