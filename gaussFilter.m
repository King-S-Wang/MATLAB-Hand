function G=gaussFilter(segma,kSize)
% Creates a 1-D Gaussian kernel of a standard deviation 'segma' and a size
% of 'kSize'. 创建标准偏差“segma”和大小“kSize”的一维高斯核。
%
% In theory, the Gaussian distribution is non-zero everywhere. In practice,
% it's effectively zero at places further away from about three standard
% deviations. Hence the reason why the kernel is suggested to be truncated
% at that point.
%理论上，高斯分布在任何地方都是非零的。 实际上，在远离三个标准偏差的地方实际上
%是零。 因此，内核被建议在这一点被截断的原因。
%
% The 2D Gaussian filter is a complete circular symmetric operator. It can be
% seperated into x and y components. The 2D convolution can be performed by
% first convolving with 1D Gaussian in the x direction and the same in the
% y direction.
%二维高斯滤波器是一个完整的圆对称算子。 它可以分成x和y两个部分。 2D卷积可以通过
%首先在x方向上以1D高斯进行卷积并且在y方向上进行相同的卷积来执行。


if nargin<1 %nargin是function变量输入数
    segma=1;
end
if nargin<2
    kSize=2*(segma*3);
end

x=-(kSize/2):(1+1/kSize):(kSize/2);
G=(1/(sqrt(2*pi)*segma)) * exp (-(x.^2)/(2*segma^2));
%高斯滤波是一种线性平滑滤波，适用于消除高斯噪声，广泛应用于图像处理的减噪过程。
%通俗的讲，高斯滤波就是对整幅图像进行加权平均的过程，每一个像素点的值，都由其
%本身和邻域内的其他像素值经过加权平均后得到。高斯滤波的具体操作是：用一个模板
%（或称卷积、掩模）扫描图像中的每一个像素，用模板确定的邻域内像素的加权平均灰
%度值去替代模板中心像素点的值。