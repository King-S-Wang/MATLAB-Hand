function featoutput=cut(Grinput,Indtaginput,BinNum,level)
%把图像切分为四块，分别统计其直方图
if level==0
    return;
end
[height,width]=size(Grinput);   %梯度图尺寸大小
%分区
half_height=ceil(height/2);
half_width=ceil(width/2);
Gr_ori1=Grinput(1:half_height,1:half_width);
Gr_ori2=Grinput(1:half_height,(1+half_width):2*half_width);
Gr_ori3=Grinput((1+half_height):2*half_height,1:half_width);
Gr_ori4=Grinput((1+half_height):2*half_height,(1+half_width):2*half_width);
Indtag_ori1=Indtaginput(1:half_height,1:half_width);
Indtag_ori2=Indtaginput(1:half_height,(1+half_width):2*half_width);
Indtag_ori3=Indtaginput((1+half_height):2*half_height,1:half_width);
Indtag_ori4=Indtaginput((1+half_height):2*half_height,(1+half_width):2*half_width);

% here we calculate 4 cells
totalnum=0;
for i=1:level
    totalnum=totalnum+4^i*BinNum;
end
featoutput = zeros(1,totalnum);
feat1 = zeros(1,BinNum);
feat2 = zeros(1,BinNum);
feat3 = zeros(1,BinNum);
feat4 = zeros(1,BinNum);

for i=1:BinNum
    feat1(i) = sum(Gr_ori1(find(Indtag_ori1==i)));
end


for i=1:BinNum
    feat2(i) = sum(Gr_ori2(find(Indtag_ori2==i)));
end


for i=1:BinNum
    feat3(i) = sum(Gr_ori3(find(Indtag_ori3==i)));
end


for i=1:BinNum
    feat4(i) = sum(Gr_ori4(find(Indtag_ori4==i)));
end
if (level-1)~=0
    totalnum1=0;
    for i=1:level-1
        totalnum1=totalnum1+4^i*BinNum;
    end
    feat_cut1 = zeros(1,totalnum);
    feat_cut2 = zeros(1,totalnum);
    feat_cut3 = zeros(1,totalnum);
    feat_cut4 = zeros(1,totalnum);
    feat_cut1=cut(Gr_ori1,Indtag_ori1,BinNum,level-1);
    feat_cut2=cut(Gr_ori2,Indtag_ori2,BinNum,level-1);
    feat_cut3=cut(Gr_ori3,Indtag_ori3,BinNum,level-1);
    feat_cut4=cut(Gr_ori4,Indtag_ori4,BinNum,level-1);
    featoutput=[feat1,feat2,feat3,feat4,feat_cut1,feat_cut2,feat_cut3,feat_cut4];
else featoutput=[feat1,feat2,feat3,feat4];
end
end
    