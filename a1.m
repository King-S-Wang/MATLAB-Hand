function varargout = hougege(varargin)
% HOUGEGE M-file for hougege.fig
%      HOUGEGE, by itself, creates a new HOUGEGE or raises the existing
%      singleton*.
%
%      H = HOUGEGE returns the handle to a new HOUGEGE or the handle to
%      the existing singleton*.
%
%      HOUGEGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HOUGEGE.M with the given input arguments.
%
%      HOUGEGE('Property','Value',...) creates a new HOUGEGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before hougege_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to hougege_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help hougege

% Last Modified by GUIDE v2.5 31-May-2011 22:38:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @hougege_OpeningFcn, ...
                   'gui_OutputFcn',  @hougege_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before hougege is made visible.
function hougege_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to hougege (see VARARGIN)

% Choose default command line output for hougege
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes hougege wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = hougege_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global filename;
global pathname;
global jb;
[filename,pathname]=uigetfile({'*.bmp;*.jpg','(*.bmp;*.jpg)';'*.bmp','(*.bmp)';'*.jpg','(*.jpg)';},'ò');
jb=filename;
axes(handles.axes1);
imshow(filename);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global filename;
global pathname;
global jb;
global n;

[filename,pathname]=uigetfile({'*.bmp;*.jpg','(*.bmp;*.jpg)';'*.bmp','(*.bmp)';'*.jpg','(*.jpg)';},'ò');
jp=filename;
axes(handles.axes3);
imshow(filename);
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
    f=feature1(im,Angle,BinNum,level,totalnum);
    fstandard(n,1:totalnum)=f(1,1:totalnum);
end
while(1)
    tag=zeros(1,2);
    for n=1:2
       % xm=sprintf('%d',n);
        %fname=input(xm,'s');
        %imidentify=imread(fname);
        if n==1 imidentify=imread(jb); end
        if n==2 imidentify=imread(jp); end
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
        %% a2
    D1L=1.8;D1R=4.0; %布   distance(1)左右门限  %D1L=1.9-->1.8  D1R=4.5-->4.0
    D2L=4.5;D2R=7  ; %剪刀 distance(2)左右门限  %D2L=4.9-->4.5  D2R=5.5-->7
    D3L=8.0;D3R=26.1;%石头 distance(3)左右门限  %D3L=9 8-->9    D3R=24.1-->26.1
    XX=5.28;         %     distance(3)异形指数
%         if distance(1)==0
%             tag(1,n)=1;%disp('a是布');
%         elseif distance(2)==0
%             tag(1,n)=2;%disp('b是剪刀');
%         elseif distance(3)==0
%             tag(1,n)=3;%disp('c是石头');

       if distance(3)>D3L||distance(2)>D3L||distance(1)>D3L||distance(3)==0
                 tag(1,n)=3;%disp('c是石头');
                 
              
       elseif distance(1)==0||(distance(1)<D1R&distance(2)>D2L&distance(2)<D2R&distance(3)<XX)
                 tag(1,n)=1;%disp('a是布');
       elseif distance(2)==0||(distance(1)>D1R&distance(2)<5.8&distance(3)<XX)
                 tag(1,n)=2;%disp('b是剪刀');
       else
                  %h=fanhui;%disp('无效手势！！请重新输入！！');
                 h = open(fanhui);
                 h=fanhui;
                 if n==1 set(handles.text1,'string','手势1错误，请重新操作'); end
                 if n==2 set(handles.text1,'string','手势2错误，请重新操作'); end
                 tag(1,n)=4;      
         break;  
        end
         
%         if distance(1)>1.9&distance(1)<4.5
%             tag(1,n)=1;%a
%         elseif distance(2)>4.9&distance(2)<5.5
%             tag(1,n)=2;%b
%         elseif distance(3)>8&distance(3)<24.1
%             tag(1,n)=3;%c·
%         else h=fanhui;
%                if n==1 set(handles.text1,'string','手势1错误，请重新操作'); end
%                if n==2 set(handles.text1,'string','手势2错误，请重新操作'); end
%                break;
%              tag(1,n)=4;
%         break;
%         end
    end
    if tag(1,1)==4||tag(1,2)==4    continue;
    end
    if (tag(1,1)==1&&tag(1,2)==3)||(tag(1,1)==2&&tag(1,2)==1)||(tag(1,1)==3&&tag(1,2)==2)
        axes(handles.axes2);imshow('win.jpg');
    end
    if (tag(1,1)==1&&tag(1,2)==1)||(tag(1,1)==2&&tag(1,2)==2)||(tag(1,1)==3&&tag(1,2)==3)
        axes(handles.axes2);imshow('peace.jpg');fanhui;
    end
    if (tag(1,1)==1&&tag(1,2)==2)||(tag(1,1)==2&&tag(1,2)==3)||(tag(1,1)==3&&tag(1,2)==1)
        axes(handles.axes2);imshow('lose.jpg');
    end
     break;
end
    
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


