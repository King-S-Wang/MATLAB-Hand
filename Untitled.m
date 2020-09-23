clear;
clc;
BinNum=36;
Angle=360;
level=2;
totalnum=BinNum;
for i=1:level
    totalnum=totalnum+4^i*BinNum;
end
fstandard=zeros(3,totalnum);
for n=1:3
    imgname=sprintf('%d.bmp',n);
    im=imread(imgname);
    if size(size(im),2)==3
       im=rgb2gray(im);
    end
    f=feature(im,Angle,BinNum,level,totalnum);
    fstandard(n,1:totalnum)=f(1,1:totalnum);
end
distance=zeros(35,3);
for m=1:35
    f=zeros(1,totalnum);
    imgname=sprintf('00%d.bmp',m);
    im=imread(imgname);
    if size(size(im),2)==3
        im=rgb2gray(im);
    end
    f=feature(im,Angle,BinNum,level,totalnum);
    %figure;bar(f);
    for i=1:3
        for j=1:totalnum
            distance(m,i)=distance(m,i)+sqrt((f(j)-fstandard(i,j))^2)
        end
    end
end