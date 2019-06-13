%% Initialization
clear ; close all; clc;
%% Set initial parameters for simulation
root=zeros(500);%%��i�������еĵ�����
leaf=zeros(1,size(root,2));%%��i������Ҷ�ڵ�ı��
branched=zeros(1,size(root,2));%%һ������֧���������
loot=zeros(1,size(root,2));%%ĳ��������ס������ֵΪ1��û����ס��Ϊ0
tree=struct('f',0,'rs',0,'ls',0,'v',0,'tag',0);
Dead=zeros(1,size(root,2));%%��ĳ����֧����һ����/����/��������סʱ����ֵΪ1������Ϊ0
cnt=2*size(root,2);
t=0;
ed=0.995;
count=10;
conversion=0;
originalNPCnum=20*size(root,2);
NPC_num=originalNPCnum;
lockedNPC=0;
NCA_num=0;
AcH_num=0*size(root,2);
Ac_num=0;
%% ����Ԫ��Ӧ��kֵ
k1=1;%NPC->NCA
k2=2;%��ҧ
k3=1.5;%֧��
k4=20;%����
keq=300;%�ữƽ�ⳣ��
kp=2;%����NPC�ữ��������
%% Initialize each polymer
for i=1:size(root,2)*4
    tree(i).f=0;
    tree(i).rs=0;
    tree(i).ls=0;
    tree(i).v=0;
end
    tree(i).tag=0;
for i=1:size(root,2)
    root(i)=1;
    leaf(i)=i;
end
%% stimulation
while conversion < ed
    root_num=sum(Dead==0);
    %locknh
    NPC_num=double(NPC_num+lockedNPC);
    s=NPC_num+AcH_num*kp;
    r=root_num;
    locked=int32(((s+r+keq)-sqrt((s+r+keq)^2-4*s*r))/2)-1;
    locked=double(locked);
    lockedNPC=int32(locked*(NPC_num/(NPC_num+AcH_num*kp)));
    lockedNPC=double(lockedNPC);
    NPC_num=NPC_num-lockedNPC;
    r1=rand(1);
    r2=rand(1);
    a1=NPC_num*k1*(r-locked);
    a2=a1+(r-locked)*k2;
    a3=a2+(r-locked)*(r-locked)*k3;
    a4=a3+(r-locked)*k4*NCA_num;
    a0=a4;
    dt = -1/a0*log(r1);
    reactType=r2*a0;
    pos = find(Dead==0);
    if length(pos)==0
        break;
    end
    x=unidrnd(length(pos));
    randroot=pos(x);
    %NPC->NCA
    if reactType>0&&reactType<=a1
        NPC_num=NPC_num-10;
        NCA_num=NCA_num+10;
    end
    %����
    if reactType>a1&&reactType<=a2
        Dead(randroot)=1;
        loot(randroot)=1;
    end
    %��֧��
    if reactType>a2&&reactType<=a3
       % randroot=unidrnd(size(root,2));
        x=unidrnd(length(pos));
        rootB=pos(x);
        tmp=randroot;
        tmp_1=0;
        while tmp~=0
            tmp_1=tmp_1+tree(tmp).v;
            tmp=tree(tmp).ls;
        end
       if(rootB~=randroot&&tmp_1~=branched(randroot))
       [root,leaf,tree,Dead,cnt]=Branch(root,leaf,tree,Dead,cnt,randroot,rootB,tmp_1);
       branched(randroot)=branched(randroot)+1;
       end
    end
    %������
    if reactType>a3&&reactType<=a4
        [root,tree]=AddNPC(root,leaf,tree,randroot);
        NCA_num=NCA_num-10;
    end
    conversion = (originalNPCnum - NPC_num-(lockedNPC)) / originalNPCnum;
    t=t+dt;
    
    if mod(count,10)==0
    [Mw,Mv,B]=retrieve(root,tree,Dead,loot);
    Params(:,count/10) =  [conversion;Mw;Mv;B;t;locked/r];
    end
    count=count+1;
    
    display(conversion);
end
x=Params(1,:);
y=Params(6,:);
L=Params(5,:);
csvwrite('20_0.csv',Params);
plot(L,x,'b');
legend('conversion');
display(Mv);