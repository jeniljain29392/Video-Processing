function varargout = GUI_DVP(varargin)
% GUI_DVP MATLAB code for GUI_DVP.fig
%      GUI_DVP, by itself, creates a new GUI_DVP or raises the existing
%      singleton*.
%
%      H = GUI_DVP returns the handle to a new GUI_DVP or the handle to
%      the existing singleton*.
%
%      GUI_DVP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_DVP.M with the given input arguments.
%
%      GUI_DVP('Property','Value',...) creates a new GUI_DVP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_DVP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_DVP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_DVP

% Last Modified by GUIDE v2.5 18-Nov-2015 02:23:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_DVP_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_DVP_OutputFcn, ...
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


% --- Executes just before GUI_DVP is made visible.
function GUI_DVP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_DVP (see VARARGIN)

% Choose default command line output for GUI_DVP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_DVP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_DVP_OutputFcn(hObject, eventdata, handles) 
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
[FileName,PathName] = uigetfile('*.txt;*.avi','Select the txt data file');
if (length(FileName)<=1)
    return;
end
h = waitbar(0.0,'Loading raw data. Please wait...');
C = strsplit(FileName,'-');
S =strsplit(C{3},'.');
dash='-';
name=strcat(C{2},dash);
final=strcat(name,S{1});
name2='-activityAnnotation.txt';
final_name=strcat(final,name2);
FullPath=[PathName FileName];
id = fopen(FullPath);
cd('/Users/prianca/Downloads/ann-ts/activityAnnotations')
global StartTime;
global EndTime;
global Activity;
[StartTime, EndTime, Activity] = textread(final_name, '%f%f%s');
[row col]=size(Activity);
cd('/Users/prianca/Documents/Fall2015/dvp/project/Project_DVP/Video-Processing')
set(handles.text5,'string',row)
set(handles.popupmenu1,'String',{Activity{:}});

delete(h);





% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global Activity;
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Activity;
global popup_sel_index;
global StartTime;
global EndTime;


popup_sel_index = get(handles.popupmenu1, 'Value');
set(handles.text11,'String',StartTime(popup_sel_index,1));
set(handles.text8,'String',EndTime(popup_sel_index,1));

