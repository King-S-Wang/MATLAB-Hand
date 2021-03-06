function f1=feature1(im,Angle,BinNum,level,totalnum)    
    %figure;imshow(im);
    im=mat2gray(im);   %CHANGE+
    im=double(im);
    [height,width]=size(im);

    BW=edge(im,'canny') ; %采用灰度或一个二值化图像作为它的输入，并返回一个与im相同大小的二值化图像BW，在函数检测到边缘的地方为1，其他地方为0。采用Canny 算子边缘定位精确性和抗噪声能力效果较好
    G=bwlabel(BW,8);
    filter=gaussFilter(1);
    %Imgfilter=conv2(G,filter,'same');
    %G=conv2(Imgfilter,filter,'same');
    %figure;imshow(G);
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
end