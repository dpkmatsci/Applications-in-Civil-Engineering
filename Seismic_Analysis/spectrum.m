function varargout = spectrum(varargin)
% SPECTRUM MATLAB code for spectrum.fig
%      SPECTRUM, by itself, creates a new SPECTRUM or raises the existing
%      singleton*.
%
%      H = SPECTRUM returns the handle to a new SPECTRUM or the handle to
%      the existing singleton*.
%
%      SPECTRUM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPECTRUM.M with the given input arguments.
%
%      SPECTRUM('Property','Value',...) creates a new SPECTRUM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before spectrum_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to spectrum_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help spectrum

% Last Modified by GUIDE v2.5 01-Nov-2016 02:05:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @spectrum_OpeningFcn, ...
                   'gui_OutputFcn',  @spectrum_OutputFcn, ...
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


% --- Executes just before spectrum is made visible.
function spectrum_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to spectrum (see VARARGIN)

% Choose default command line output for spectrum
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes spectrum wait for user response (see UIRESUME)
 %uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = spectrum_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tmp=get(handles.mxmtmprd,'string');
tmp=str2double(tmp);
a=get(handles.dampingconstant,'string');
ch=get(handles.radiobutton4,'value');
hk=get(handles.radiobutton5,'value');
[~,~,achk]=fileparts(a);
ach1=strcmpi(achk,'.dat');
ach2=strcmpi(achk,'.txt');
if ch==1 && hk==0
    if ach1==0 && ach2==0
        a=str2double(a);
    else
        h=msgbox('give only single value of damping constant','Error','error');
    end
else
  if ach1==1 || ach2==1  
    a=load(a);
  else
      h=msgbox('give damping constant in form of .dat or .txt only','Error','error');
  end
end
b=get(handles.fnctnfilename,'string');
dh=get(handles.radiobutton6,'value');
hd=get(handles.radiobutton7,'value');
[~,~,bchk]=fileparts(b);
bch1=strcmpi(bchk,'.dat');
bch2=strcmpi(bchk,'.txt');
if dh==1 && hd==0  
  if bch1==1 || bch2==1  
    c=load(b);
  else
      h=msgbox('provide ground acceleration in form of .dat or .txt file','Error','error');
      c=0:0.02:30;
    for i=1:size(c,2)
        c(2,i)=0;
    end
    c=c';
  end
end
if dh==0 && hd==1
  if bch1==0 && bch2==0  
    fnc=inline(b);
    c=0:0.02:30;
    for i=1:size(c,2)
        c(2,i)=fnc(c(1,i));
    end
    c=c';
  else
      h=msgbox('provide function for ground acceleration','Error','error');
      c=0:0.02:30;
    for i=1:size(c,2)
        c(2,i)=0;
    end
    c=c';
  end
end
if size(a,1)>size(a,2)
    a=a';
end
fnlans=rspsptr(c,tmp,a);
ss=get(handles.popupmenu1,'value');
switch ss
    case 1
        helpdlg('kindly select an option','Spectrum');
    case 2
        for i=1:size(a,2)
            if i==1
                plot(fnlans(:,1),fnlans(:,2+(i-1)*3),'k');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('RELATIVE DISPLACEMENT(cm)');
                    title('RELATIVE DISPLACEMENT SPECTRUM');
                    hold off;
                end
            end
            if i==2
                plot(fnlans(:,1),fnlans(:,2+(i-1)*3),'y');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('RELATIVE DISPLACEMENT(cm)');
                    title('RELATIVE DISPLACEMENT SPECTRUM');
                    hold off;
                end
            end
            if i==3
                plot(fnlans(:,1),fnlans(:,2+(i-1)*3),'m');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('RELATIVE DISPLACEMENT(cm)');
                    title('RELATIVE DISPLACEMENT SPECTRUM');
                    hold off;
                end
            end
            if i==4
                plot(fnlans(:,1),fnlans(:,2+(i-1)*3),'c');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('RELATIVE DISPLACEMENT(cm)');
                    title('RELATIVE DISPLACEMENT SPECTRUM');
                    hold off;
                end
            end
            if i==5
                plot(fnlans(:,1),fnlans(:,2+(i-1)*3),'b');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('RELATIVE DISPLACEMENT(cm)');
                    title('RELATIVE DISPLACEMENT SPECTRUM');
                    hold off;
                end
            end
            if i==6
                plot(fnlans(:,1),fnlans(:,2+(i-1)*3),'g');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('RELATIVE DISPLACEMENT(cm)');
                    title('RELATIVE DISPLACEMENT SPECTRUM');
                    hold off;
                end
            end
            if i==7
                plot(fnlans(:,1),fnlans(:,2+(i-1)*3),'r');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('RELATIVE DISPLACEMENT(cm)');
                    title('RELATIVE DISPLACEMENT SPECTRUM');
                    hold off;
                end
            end
        end
    case 3
        for i=1:size(a,2)
            if i==1
                plot(fnlans(:,1),fnlans(:,3+(i-1)*3),'k');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('PSEUDO VELOCITY(cm/s)');
                    title('PSEUDO VELOCITY SPECTRUM');
                    hold off;
                end
            end
            if i==2
                plot(fnlans(:,1),fnlans(:,3+(i-1)*3),'y');
                hold on
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('PSEUDO VELOCITY(cm/s)');
                    title('PSEUDO VELOCITY SPECTRUM');
                    hold off;
                end
            end
            if i==3
                plot(fnlans(:,1),fnlans(:,3+(i-1)*3),'m');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('PSEUDO VELOCITY(cm/s)');
                    title('PSEUDO VELOCITY SPECTRUM');
                    hold off;
                end
            end
            if i==4
                plot(fnlans(:,1),fnlans(:,3+(i-1)*3),'c');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('PSEUDO VELOCITY(cm/s)');
                    title('PSEUDO VELOCITY SPECTRUM');
                    hold off;
                end
            end
            if i==5
                plot(fnlans(:,1),fnlans(:,3+(i-1)*3),'b');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('PSEUDO VELOCITY(cm/s)');
                    title('PSEUDO VELOCITY SPECTRUM');
                    hold off;
                end
            end
            if i==6
                plot(fnlans(:,1),fnlans(:,3+(i-1)*3),'g');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('PSEUDO VELOCITY(cm/s)');
                    title('PSEUDO VELOCITY SPECTRUM');
                    hold off;
                end
            end
            if i==7
                plot(fnlans(:,1),fnlans(:,3+(i-1)*3),'r');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('PSEUDO VELOCITY(cm/s)');
                    title('PSEUDO VELOCITY SPECTRUM');
                    hold off;
                end
            end
        end
    case 4
        for i=1:size(a,2)
            if i==1
                plot(fnlans(:,1),fnlans(:,4+(i-1)*3),'k');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('PSEUDO ACCELERATION(A/g)');
                    title('PSEUDO ACCELERATION SPECTRUM');
                    hold off;
                end
            end
            if i==2
                plot(fnlans(:,1),fnlans(:,4+(i-1)*3),'y');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('PSEUDO ACCELERATION(A/g)');
                    title('PSEUDO ACCELERATION SPECTRUM');
                    hold off;
                end
            end
            if i==3
                plot(fnlans(:,1),fnlans(:,4+(i-1)*3),'m');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('PSEUDO ACCELERATION(A/g)');
                    title('PSEUDO ACCELERATION SPECTRUM');
                    hold off;
                end
            end
            if i==4
                plot(fnlans(:,1),fnlans(:,4+(i-1)*3),'c');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('PSEUDO ACCELERATION(A/g)');
                    title('PSEUDO ACCELERATION SPECTRUM');
                    hold off;
                end
            end
            if i==5
                plot(fnlans(:,1),fnlans(:,4+(i-1)*3),'b');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('PSEUDO ACCELERATION(A/g)');
                    title('PSEUDO ACCELERATION SPECTRUM');
                    hold off;
                end
            end
            if i==6
                plot(fnlans(:,1),fnlans(:,4+(i-1)*3),'g');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('PSEUDO ACCELERATION(A/g)');
                    title('PSEUDO ACCELERATION SPECTRUM');
                    hold off;
                end
            end
            if i==7
                plot(fnlans(:,1),fnlans(:,4+(i-1)*3),'r');
                hold on;
                if i==size(a,2)
                    xlabel('TIME PERIOD(s)');
                    ylabel('PSEUDO ACCELERATION(A/g)');
                    title('PSEUDO ACCELERATION SPECTRUM');
                    hold off;
                end
            end
        end
end
   



% --- Executes during object creation, after setting all properties.
function dampingconstant_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dampingconstant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dampingconstant_Callback(hObject, eventdata, handles)
% hObject    handle to dampingconstant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dampingconstant as text
%        str2double(get(hObject,'String')) returns contents of dampingconstant as a double



function mxmtmprd_Callback(hObject, eventdata, handles)
% hObject    handle to mxmtmprd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mxmtmprd as text
%        str2double(get(hObject,'String')) returns contents of mxmtmprd as a double



% --- Executes during object creation, after setting all properties.
function mxmtmprd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mxmtmprd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fnctnfilename_Callback(hObject, eventdata, handles)
% hObject    handle to fnctnfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fnctnfilename as text
%        str2double(get(hObject,'String')) returns contents of fnctnfilename as a double


% --- Executes during object creation, after setting all properties.
function fnctnfilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fnctnfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton3.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton2.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes during object creation, after setting all properties.
function uibuttongroup2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6


% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7


% --- Executes during object creation, after setting all properties.
function radiobutton5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function radiobutton4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
