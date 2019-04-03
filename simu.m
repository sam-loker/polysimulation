%% Initialization
clear ; close all; clc;
%% Set initial parameters for simulation
root=zeros(500);
leaf=zeros(1,size(root,2));
branched=zeros(1,size(root,2));
locked=zeros(1,size(root,2));
tree=struct('f',0,'rs',0,'ls',0,'v',0,'tag',0);
cnt=2*size(root,2);
Dead=zeros(1,size(root,2));
t=0;
originalNPCnum=20*size(root,2);
NPC_num=originalNPCnum;
NCA_num=0;
AcH_num=0;
Ac_num=0;
k1=1;
k2=1;
k3=1;
k4=1;
k5=0;
k6=0.625;
%Initialize each polymer
for i=1:size(root,2)*4
    tree(i).f=0;
    tree(i).rs=0;
    tree(i).ls=0;
    tree(i).v=0;
    tree(i).tag=0;
end
for i=1:size(root,2)
    root(i)=1;
    leaf(i)=i;
end
conversion=0;
%Params= zeros(5,20000);
ed=0.8;
count=1;
while conversion<=ed
    root_num = sum (Dead==0);
   % if NPC_num+NCA_num+root_num==ceil((originalNPCnum+size(root,2)))/2
    %    duplicate();
    %end
    r1=rand(1);
    r2=rand(1);
    a1=NPC_num*k1*root_num;
    a2=a1+AcH_num*k2*root_num;
    a3=a2+Ac_num*k3*(size(root,2)-root_num);
    a4=a3+NCA_num*k4*root_num;
    a5=a4+k5*root_num;
    a6=a5+k6*root_num*root_num;
    a0=a6;
    dt = -1/a0*log(r1);
    reactType=r2*a0;
    pos = find(Dead==0);
    if length(pos)==0
        break;
    end
    x=unidrnd(length(pos));
    randroot=pos(x);
    if reactType>0&&reactType<=a1
        NPC_num=NPC_num-1;
        NCA_num=NCA_num+1;
    end
    if reactType>a1&&reactType<=a2
        Dead(randroot)=1;
        locked(randroot)=1;
        AcH_num=AcH_num-1;
        Ac_num=Ac_num+1;
    end
    if reactType>a2&&reactType<=a3
        poslock=find(locked);
        Lockedroot=unidrnd(length(poslock));
        Dead(poslock(Lockedroot))=0;
        locked(poslock(Lockedroot))=0;
        AcH_num=AcH_num+1;
        Ac_num=Ac_num-1;
    end
    if reactType>a3&&reactType<=a4
        [root,tree]=AddNPC(root,leaf,tree,randroot);
        NCA_num=NCA_num-1;
    end
    if reactType>a4&&reactType<=a5
        %Suicide();
        
    end
    if reactType>a5&&reactType<=a6
        randroot=unidrnd(size(root,2));
        rootB=unidrnd(length(pos));
        tmp=randroot;
        tmp_1=0;
        while tmp~=0
            tmp_1=tmp_1+tree(tmp).v;
            tmp=tree(tmp).ls;
        end
       if(rootB~=randroot&&tmp_1~=branched(randroot))
       [root,leaf,tree,Dead,cnt]=Branch(root,leaf,tree,Dead,cnt,randroot,pos(rootB),tmp_1);
       branched(randroot)=branched(randroot)+1;
       end
    end
   
	
    conversion = (originalNPCnum - NPC_num-NCA_num) / originalNPCnum;
    t=t+dt;
    [Mw,Mv,B]=retrieve(root,tree,Dead,locked);
    Params(:,count) =  [conversion;Mw;Mv;B;t];
    count=count+1;
display(conversion);
end
x=Params(1,:);
y=Params(2,:);
plot(x,y);