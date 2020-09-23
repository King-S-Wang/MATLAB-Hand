function G=gaussFilter(segma,kSize)
% Creates a 1-D Gaussian kernel of a standard deviation 'segma' and a size
% of 'kSize'. ������׼ƫ�segma���ʹ�С��kSize����һά��˹�ˡ�
%
% In theory, the Gaussian distribution is non-zero everywhere. In practice,
% it's effectively zero at places further away from about three standard
% deviations. Hence the reason why the kernel is suggested to be truncated
% at that point.
%�����ϣ���˹�ֲ����κεط����Ƿ���ġ� ʵ���ϣ���Զ��������׼ƫ��ĵط�ʵ����
%���㡣 ��ˣ��ں˱���������һ�㱻�ضϵ�ԭ��
%
% The 2D Gaussian filter is a complete circular symmetric operator. It can be
% seperated into x and y components. The 2D convolution can be performed by
% first convolving with 1D Gaussian in the x direction and the same in the
% y direction.
%��ά��˹�˲�����һ��������Բ�Գ����ӡ� �����Էֳ�x��y�������֡� 2D�������ͨ��
%������x��������1D��˹���о��������y�����Ͻ�����ͬ�ľ����ִ�С�


if nargin<1 %nargin��function����������
    segma=1;
end
if nargin<2
    kSize=2*(segma*3);
end

x=-(kSize/2):(1+1/kSize):(kSize/2);
G=(1/(sqrt(2*pi)*segma)) * exp (-(x.^2)/(2*segma^2));
%��˹�˲���һ������ƽ���˲���������������˹�������㷺Ӧ����ͼ����ļ�����̡�
%ͨ�׵Ľ�����˹�˲����Ƕ�����ͼ����м�Ȩƽ���Ĺ��̣�ÿһ�����ص��ֵ��������
%����������ڵ���������ֵ������Ȩƽ����õ�����˹�˲��ľ�������ǣ���һ��ģ��
%����ƾ������ģ��ɨ��ͼ���е�ÿһ�����أ���ģ��ȷ�������������صļ�Ȩƽ����
%��ֵȥ���ģ���������ص��ֵ��