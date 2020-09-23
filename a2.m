clear;
clc;
BinNum=36;
Angle=360;
level=2;
totalnum=BinNum;
flag=0;
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
    f=feature1(im,Angle,BinNum,level,totalnum);
    fstandard(n,1:totalnum)=f(1,1:totalnum);
end
while(1)
    tag=zeros(1,2);
    for n=1:2
        xm=sprintf('�������%d�����ƣ�',n);
        fname=input(xm,'s');
        imidentify=imread(fname);
        if n==1 subplot(1,3,1);imshow(imidentify);end
        if n==2 subplot(1,3,3);imshow(imidentify);end
        if size(size(imidentify),2)==3
            imidentify=rgb2gray(imidentify);
        end
        fidentify=feature1(imidentify,Angle,BinNum,level,totalnum);
        distance=zeros(1,3);
        for i=1:3
            for j=1:totalnum
                distance(1,i)=distance(1,i)+sqrt((fidentify(j)-fstandard(i,j))^2);
            end
        end
    %%
    D1L=1.8;D1R=4.0; %��   distance(1)��������  %D1L=1.9-->1.8  D1R=4.5-->4.0
    D2L=4.5;D2R=7  ; %���� distance(2)��������  %D2L=4.9-->4.5  D2R=5.5-->7
    D3L=8.0;D3R=26.1;%ʯͷ distance(3)��������  %D3L=9 8-->9    D3R=24.1-->26.1
    XX=5.28;         %     distance(3)����ָ��
        if distance(1)==0
            tag(1,n)=1;disp('a�ǲ�');
        elseif distance(2)==0
            tag(1,n)=2;disp('b�Ǽ���');
        elseif distance(3)==0
            tag(1,n)=3;disp('c��ʯͷ');
        else
              if distance(3)>D3L||distance(2)>D3L||distance(1)>D3L
                 tag(1,n)=3;disp('c��ʯͷ');
              
              elseif distance(1)<D1R&distance(2)>D2L&distance(2)<D2R&distance(3)<XX
                 tag(1,n)=1;disp('a�ǲ�');
              elseif distance(1)>D1R&distance(2)<5.8&distance(3)<XX
                 tag(1,n)=2;disp('b�Ǽ���');
              else
                  disp('��Ч���ƣ������������룡��');
                  tag(1,n)=4;break;

              
            end
         end
    end   
    
        
  
    if tag(1,1)==4||tag(1,2)==4 continue;
    end
    if (tag(1,1)==1&&tag(1,2)==3)||(tag(1,1)==2&&tag(1,2)==1)||(tag(1,1)==3&&tag(1,2)==2)
        subplot(1,3,2);imshow('win.jpg');
    end
    if (tag(1,1)==1&&tag(1,2)==1)||(tag(1,1)==2&&tag(1,2)==2)||(tag(1,1)==3&&tag(1,2)==3)
        subplot(1,3,2);imshow('peace.jpg');
    end
    if (tag(1,1)==1&&tag(1,2)==2)||(tag(1,1)==2&&tag(1,2)==3)||(tag(1,1)==3&&tag(1,2)==1)
        subplot(1,3,2);imshow('lose.jpg');
    end

    xn=input('��ѡ�������(c)�����˳�(q):','s');
    switch(xn)
        case 'c'  
            continue;
        case 'q'  
            break;
    end
end
    
