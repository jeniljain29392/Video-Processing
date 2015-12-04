function varargout = output(varargin)
% OUTPUT MATLAB code for output.fig
%      OUTPUT, by itself, creates a new OUTPUT or raises the existing
%      singleton*.
%
%      H = OUTPUT returns the handle to a new OUTPUT or the handle to
%      the existing singleton*.
%
%      OUTPUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OUTPUT.M with the given input arguments.
%
%      OUTPUT('Property','Value',...) creates a new OUTPUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before output_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to output_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help output

% Last Modified by GUIDE v2.5 03-Dec-2015 19:50:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @output_OpeningFcn, ...
                   'gui_OutputFcn',  @output_OutputFcn, ...
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


% --- Executes just before output is made visible.
function output_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to output (see VARARGIN)

% Choose default command line output for output
handles.output = hObject;
load('Ranking.mat');

global cosine_str;
global cosine_startVid;
global cosine_stopVid;

global eucli_str;
global eucli_startVid;
global eucli_stopVid;

for i = 1:10
      c(i) = Ranking.Cosine.ExtractMin();
      e(i) = Ranking.Euclidean.ExtractMin();
      
      cosine_str{i} = strcat('rgb-',c(i).name(8:11), '.avi');
      cosine_startVid(i) = c(i).start;
      cosine_stopVid(i) = c(i).stop;
      
      eucli_str{i} = strcat('rgb-',e(i).name(8:11), '.avi');
      eucli_startVid(i) = e(i).start;
      eucli_stopVid(i) = e(i).stop;
end
set(handles.listbox1, 'String',cosine_str);
set(handles.listbox2, 'String',eucli_str);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes output wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = output_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
global cosine_str;
global cosine_startVid;
global cosine_stopVid;
global video_path;
a = get(handles.listbox1, 'Value');
playVideo(char(strcat(video_path, '\', cosine_str(a))), cosine_startVid(a), cosine_stopVid(a));

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
global eucli_str;
global eucli_startVid;
global eucli_stopVid;
global video_path;
a = get(handles.listbox2, 'Value');
playVideo(char(strcat(video_path, '\', eucli_str(a))), eucli_startVid(a), eucli_stopVid(a));


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global video_path;
video_path = uigetdir('C:\');
set(handles.pushbutton1, 'String', video_path);
