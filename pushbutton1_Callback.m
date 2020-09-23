function pushbutton1_Callback(hObject, eventdata, handles)
global filename;
global pathname;
global jb;
[filename,pathname]=uigetfile({'*.bmp;*.jpg','(*.bmp;*.jpg)';'*.bmp','(*.bmp)';'*.jpg','(*.jpg)';},'¨°');
jb=filename;
axes(handles.axes1);
imshow(filename);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
