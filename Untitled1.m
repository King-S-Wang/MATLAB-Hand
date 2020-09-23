  close all;clear all;clc;
  totalnum=756;
  BinNum=36;
Angle=360;
level=2;
%totalnum=BinNum;
  I= imread('002.bmp');
  imshow(I)
  I=rgb2gray(I);
    imshow(I)
    %im=double(I);
    [height,width]=size(I);
    %BW=edge(I,'logical','nonsparse',I,'I',1);
    BW=edge(I,'Canny') ; %���ûҶȻ�һ����ֵ��ͼ��I��Ϊ�������룬������һ����I��ͬ��С�Ķ�ֵ��ͼ��BW���ں�����⵽��Ե�ĵط�Ϊ1�������ط�Ϊ0������Canny ���ӱ�Ե��λ��ȷ�ԺͿ���������Ч���Ϻ�
    G=bwlabel(BW,8);
    filter=gaussFilter(1);
    Imgfilter=conv2(G,filter,'same');
    G=conv2(Imgfilter,filter,'same');
    figure;imshow(G);
    f1=zeros(1,totalnum);    
    %% Gradient and Gradient angle Computation
    [GradientX,GradientY]=gradient(double(G));
    % calculate the norm of gradient
    Gr=sqrt(GradientX.^2+GradientY.^2);
    % Calculate the angle
    index=find(GradientX == 0);
    GradientX(index)=1e-5;
    YX=GradientY./GradientX;
    if Angle==180,A=((atan(YX)+(pi/2))*180)./pi; end
    if Angle==360,A=((atan2(GradientY,GradientX)+pi).*180)./pi; end
    %% Spatial / Orientation Binning
    nAngle=Angle/BinNum;
    IndTag=ceil(A./nAngle);
    for i=1:BinNum
        f1(i)=sum(Gr(find(IndTag==i)));
    end
    feat=cut(Gr,IndTag,BinNum,level);
    f1((1+BinNum):totalnum)=feat;
    f1=f1./(height*width);
