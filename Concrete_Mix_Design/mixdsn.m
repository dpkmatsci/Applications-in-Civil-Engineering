function varargout = mixdsn(varargin)
% MIXDSN MATLAB code for mixdsn.fig
%      MIXDSN, by itself, creates a new MIXDSN or raises the existing
%      singleton*.
%
%      H = MIXDSN returns the handle to a new MIXDSN or the handle to
%      the existing singleton*.
%
%      MIXDSN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MIXDSN.M with the given input arguments.
%
%      MIXDSN('Property','Value',...) creates a new MIXDSN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mixdsn_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mixdsn_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mixdsn

% Last Modified by GUIDE v2.5 24-Sep-2017 23:57:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mixdsn_OpeningFcn, ...
                   'gui_OutputFcn',  @mixdsn_OutputFcn, ...
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


% --- Executes just before mixdsn is made visible.
function mixdsn_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mixdsn (see VARARGIN)

% Choose default command line output for mixdsn
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mixdsn wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mixdsn_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in trgtpush.
function trgtpush_Callback(hObject, eventdata, handles)
% hObject    handle to trgtpush (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in clct.
function clct_Callback(hObject, eventdata, handles)
% hObject    handle to clct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cmsp=get(handles.cmntspgr,'string');
cmsp=str2double(cmsp);
crsp=get(handles.crsspgr,'string');
crsp=str2double(crsp);
crsrf=get(handles.crsfrmstr,'string');
crsrf=str2double(crsrf);
crwabs=get(handles.crswtrabs,'string');
crwabs=str2double(crwabs);
fnsp=get(handles.fnspgr,'string');
fnsp=str2double(fnsp);
fnwabs=get(handles.sndwabs,'string');
fnwabs=str2double(fnwabs);
fnsrf=get(handles.sndfrmstr,'string');
fnsrf=str2double(fnsrf);
air=get(handles.airentr,'string');
air=str2double(air);
wrkabl=get(handles.workabl,'string');
wrkabl=str2double(wrkabl);
volm=get(handles.vol,'string');
volm=str2double(volm);
wc=get(handles.wcratio,'string');
wc=str2double(wc);
agrtyp=get(handles.aggrtype,'value');
switch agrtyp 
    case 1
        helpdlg('kindly select an option','Aggregate Type');
    case 2
        agrtyp=1;
    case 3
        agrtyp=2;
    case 4
        agrtyp=3;
end
szaggr=get(handles.sizaggr,'value');
switch szaggr 
    case 1
        helpdlg('kindly select an option','Maximum Aggregate Size');
    case 2
        mxsag=10;
    case 3
        mxsag=20;
    case 4
        mxsag=40;
end
fngr=get(handles.popupmenu8,'value');
switch fngr 
    case 1
        helpdlg('kindly select an option','Fine Aggregate Grading');
    case 2
        fngrd=1;
    case 3
        fngrd=2;
    case 4
        fngrd=3;
    case 5
        fngrd=4;
end
fk=get(handles.concgrd,'value');
switch fk 
    case 1
        helpdlg('kindly select an option','Gradation of Concrete Mix');
    case 2
        fck=10;
    case 3
        fck=15;
    case 4
        fck=20;
    case 5
        fck=25;
    case 6
        fck=30;
    case 7
        fck=35;
    case 8
        fck=40;
    case 9
        fck=45;
    case 10
        fck=50;
    case 11
        fck=55;    
end
[wtr,crsagr,fnagr,cmnt,fckt]=guimixdsgn(fck,wc,mxsag,agrtyp,fngrd,wrkabl,air,cmsp,fnsp,crsp,fnsrf,crsrf,fnwabs,crwabs);
wtr=wtr*volm;
crsagr=crsagr*volm;
fnagr=fnagr*volm;
cmnt=cmnt*volm;
set(handles.trgt,'string',fckt);
set(handles.rsltwtr,'string',wtr);
set(handles.rsltcmnt,'string',cmnt);
set(handles.rsltaggrg,'string',crsagr);
set(handles.rsltsnd,'string',fnagr);




function crsspgr_Callback(hObject, eventdata, handles)
% hObject    handle to crsspgr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crsspgr as text
%        str2double(get(hObject,'String')) returns contents of crsspgr as a double


% --- Executes during object creation, after setting all properties.
function crsspgr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crsspgr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function crsfrmstr_Callback(hObject, eventdata, handles)
% hObject    handle to crsfrmstr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crsfrmstr as text
%        str2double(get(hObject,'String')) returns contents of crsfrmstr as a double


% --- Executes during object creation, after setting all properties.
function crsfrmstr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crsfrmstr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function crswtrabs_Callback(hObject, eventdata, handles)
% hObject    handle to crswtrabs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crswtrabs as text
%        str2double(get(hObject,'String')) returns contents of crswtrabs as a double


% --- Executes during object creation, after setting all properties.
function crswtrabs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crswtrabs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sizaggr.
function sizaggr_Callback(hObject, eventdata, handles)
% hObject    handle to sizaggr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sizaggr contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sizaggr


% --- Executes during object creation, after setting all properties.
function sizaggr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sizaggr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fnspgr_Callback(hObject, eventdata, handles)
% hObject    handle to fnspgr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fnspgr as text
%        str2double(get(hObject,'String')) returns contents of fnspgr as a double


% --- Executes during object creation, after setting all properties.
function fnspgr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fnspgr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sndgrd_Callback(hObject, eventdata, handles)
% hObject    handle to sndgrd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sndgrd as text
%        str2double(get(hObject,'String')) returns contents of sndgrd as a double


% --- Executes during object creation, after setting all properties.
function sndgrd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sndgrd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sndwabs_Callback(hObject, eventdata, handles)
% hObject    handle to sndwabs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sndwabs as text
%        str2double(get(hObject,'String')) returns contents of sndwabs as a double


% --- Executes during object creation, after setting all properties.
function sndwabs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sndwabs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sndfrmstr_Callback(hObject, eventdata, handles)
% hObject    handle to sndfrmstr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sndfrmstr as text
%        str2double(get(hObject,'String')) returns contents of sndfrmstr as a double


% --- Executes during object creation, after setting all properties.
function sndfrmstr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sndfrmstr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cmntspgr_Callback(hObject, eventdata, handles)
% hObject    handle to cmntspgr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmntspgr as text
%        str2double(get(hObject,'String')) returns contents of cmntspgr as a double


% --- Executes during object creation, after setting all properties.
function cmntspgr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmntspgr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in concgrd.
function concgrd_Callback(hObject, eventdata, handles)
% hObject    handle to concgrd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns concgrd contents as cell array
%        contents{get(hObject,'Value')} returns selected item from concgrd


% --- Executes during object creation, after setting all properties.
function concgrd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to concgrd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in env.
function env_Callback(hObject, eventdata, handles)
% hObject    handle to env (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns env contents as cell array
%        contents{get(hObject,'Value')} returns selected item from env


% --- Executes during object creation, after setting all properties.
function env_CreateFcn(hObject, eventdata, handles)
% hObject    handle to env (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function workabl_Callback(hObject, eventdata, handles)
% hObject    handle to workabl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of workabl as text
%        str2double(get(hObject,'String')) returns contents of workabl as a double


% --- Executes during object creation, after setting all properties.
function workabl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to workabl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in aggrtype.
function aggrtype_Callback(hObject, eventdata, handles)
% hObject    handle to aggrtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns aggrtype contents as cell array
%        contents{get(hObject,'Value')} returns selected item from aggrtype


% --- Executes during object creation, after setting all properties.
function aggrtype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aggrtype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wcratio_Callback(hObject, eventdata, handles)
% hObject    handle to wcratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wcratio as text
%        str2double(get(hObject,'String')) returns contents of wcratio as a double


% --- Executes during object creation, after setting all properties.
function wcratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wcratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vol_Callback(hObject, eventdata, handles)
% hObject    handle to vol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vol as text
%        str2double(get(hObject,'String')) returns contents of vol as a double


% --- Executes during object creation, after setting all properties.
function vol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function airentr_Callback(hObject, eventdata, handles)
% hObject    handle to airentr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of airentr as text
%        str2double(get(hObject,'String')) returns contents of airentr as a double


% --- Executes during object creation, after setting all properties.
function airentr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to airentr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function trgt_Callback(hObject, eventdata, handles)
% hObject    handle to trgt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trgt as text
%        str2double(get(hObject,'String')) returns contents of trgt as a double


% --- Executes during object creation, after setting all properties.
function trgt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trgt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
