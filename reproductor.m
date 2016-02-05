%#function internal.IntervalTimer
function varargout = reproductor(varargin)
% REPRODUCTOR MATLAB code for reproductor.fig
%      REPRODUCTOR, by itself, creates a new REPRODUCTOR or raises the existing
%      singleton*.
%
%      H = REPRODUCTOR returns the handle to a new REPRODUCTOR or the handle to
%      the existing singleton*.
%
%      REPRODUCTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REPRODUCTOR.M with the given input arguments.
%
%      REPRODUCTOR('Property','Value',...) creates a new REPRODUCTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before reproductor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to reproductor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help reproductor

% Last Modified by GUIDE v2.5 02-Nov-2015 21:40:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @reproductor_OpeningFcn, ...
                   'gui_OutputFcn',  @reproductor_OutputFcn, ...
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


% --- Executes just before reproductor is made visible.
function reproductor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to reproductor (see VARARGIN)

% Choose default command line output for reproductor
handles.output = hObject;
movegui(gcf,'center');
set(handles.pushbutton1,'enable','off');
set(handles.pushbutton2,'enable','off');
set(handles.pushbutton4,'enable','off');
set(handles.pushbutton5,'enable','off');
set(handles.pushbutton6,'enable','off');
set(handles.pushbutton7,'enable','off');
axes(handles.axes2);
title('Pitch Extraction');
xlabel('Time (sec)');
ylabel('Pitch (Hz)');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes reproductor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = reproductor_OutputFcn(hObject, eventdata, handles) 
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
myGUIdata = guidata(handles.figure1);
x = myGUIdata.audioData;
fs = myGUIdata.samplingFrequency;
myGUIdata.player = audioplayer(x/max(abs(x))*0.9,fs);
myGUIdata.flag = 1;
guidata(handles.figure1,myGUIdata);
global pl stop_pl;
stop_pl = 1;
pl = audioplayer(x,fs);
set(handles.pushbutton4,'enable','on');
play(pl);
while (stop_pl == 1)
    c=get(pl,'CurrentSample');
    t=get(pl,'TotalSamples');
    sliderval = c/t;
    set(handles.playslider,'Value',sliderval);
    guidata(hObject, handles);
    pause(.1);
end
guidata(handles.figure1,myGUIdata);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGUIdata = guidata(handles.figure1);
set(handles.pushbutton4,'enable','off');
global pl stop_pl;
stop_pl = 0;
stop (pl);
guidata(handles.figure1,myGUIdata);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGUIdata = guidata(handles.figure1);
set(handles.archivo,'string',strcat(''));
set(handles.tono,'string',strcat(''));
set(handles.pnotas,'string',strcat(''));
set(handles.listbox1,'string',strcat(''));
set(handles.pushbutton6,'enable','off');
set(handles.pushbutton7,'enable','off');
axes(handles.axes2);
cla;
[file,path] = uigetfile('*.wav','Seleccione un archivo de sonido');
set(handles.pushbutton1,'enable','on');
set(handles.pushbutton2,'enable','on');
set(handles.pushbutton5,'enable','on');
if length(file) == 1 && length(path) == 1
    if file == 0 || path == 0
        disp('La carga a sido cancelada!');
        set(handles.pushbutton1,'enable','off');
        set(handles.pushbutton2,'enable','off');
        set(handles.pushbutton4,'enable','off');
        set(handles.pushbutton5,'enable','off');
        return;
    end;
end;
set(handles.archivo,'string',strcat([path file]));
[x,fs] = audioread([path file]);
myGUIdata.audioData = x(:,1);
myGUIdata.loadedData = x;
myGUIdata.samplingFrequency = fs;
myGUIdata.loadpath = path;
myGUIdata.loadfile = file;
guidata(handles.figure1,myGUIdata);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGUIdata = guidata(handles.figure1);
global pl stop_pl;
if(stop_pl == 1)
    stop_pl = 0;
    pause(pl);
    
else
    resume(pl)
    stop_pl = 1;
    while (stop_pl == 1)
        c=get(pl,'CurrentSample');
        t=get(pl,'TotalSamples');
        sliderval = c/t;
        set(handles.playslider,'Value',sliderval);
        guidata(hObject, handles);
        %disp(myGUIdata.flag)
        pause(.1);
    end
end
guidata(handles.figure1,myGUIdata);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton5,'enable','off');
myGUIdata = guidata(handles.figure1);
timerVal=tic;
load('red\soundnet.mat');
axes(handles.axes2)
[entrada,t,freq,freqn] = bsefreqtry([myGUIdata.loadpath myGUIdata.loadfile]);
salida = net(entrada);
m=max(salida(:));
[fil,col]=find(salida==m);
toc(timerVal);
elapsedTime = toc(timerVal);
set(handles.analisis,'string',(elapsedTime));
switch col
    case 1
        set(handles.tono,'string',strcat('Cmajor/Aminor'));
        set(handles.pnotas,'string','C D E F G A B');
        errorf=[34.6500 38.8900 46.2500 51.9100 58.2700];
        perror=errorfreq(freqn,errorf);
        axes(handles.axes2);
        hold on
        for i=1:1:size(perror')
            plot(t(1,perror(1,i)),freq(1,perror(1,i)),'ro');
            err(1,i)={strcat(num2str(t(1,perror(1,i))),'--',num2str(freq(1,perror(1,i))))};
        end
        set(handles.listbox1, 'String', err);
        legend({'Estimado','Error'});
    case 2
        set(handles.tono,'string',strcat('C#major/A#minor'));
        set(handles.pnotas,'string','C# D# F F# G# A# C');
        errorf=[36.7100 41.2000 49.0000 55.0000 61.7400];
        perror=errorfreq(freqn,errorf);
        axes(handles.axes2);
        hold on
        for i=1:1:size(perror')
            plot(t(1,perror(1,i)),freq(1,perror(1,i)),'ro');
            err(1,i)={strcat(num2str(t(1,perror(1,i))),'--',num2str(freq(1,perror(1,i))))};
        end
        set(handles.listbox1, 'String', err);
        legend({'Estimado','Error'});
    case 3
        set(handles.tono,'string',strcat('Dmajor/Bminor'));
        set(handles.pnotas,'string','D E F# G A B C#');
        errorf=[32.7000 38.8900 43.6500 51.9100 58.2700];
        perror=errorfreq(freqn,errorf);
        axes(handles.axes2);
        hold on
        for i=1:1:size(perror')
            plot(t(1,perror(1,i)),freq(1,perror(1,i)),'ro')
            err(1,i)={strcat(num2str(t(1,perror(1,i))),'--',num2str(freq(1,perror(1,i))))};
        end
        set(handles.listbox1, 'String', err);
        legend({'Estimado','Error'});
    case 4
        set(handles.tono,'string',strcat('D#major/Cminor'));
        set(handles.pnotas,'string','D# F G G# A# C D');
        errorf=[34.6500 38.8900 41.2000 46.2500 55.0000];
        perror=errorfreq(freqn,errorf);
        axes(handles.axes2);
        hold on
        for i=1:1:size(perror')
            plot(t(1,perror(1,i)),freq(1,perror(1,i)),'ro')
            %disp(t(1,perror(1,i)));
            %disp(freqn(1,perror(1,i)))
            %switch freqn(1,perror(1,i))
            %    case 55.0000
            %        disp('A');
            %end
            err(1,i)={strcat(num2str(t(1,perror(1,i))),'--',num2str(freq(1,perror(1,i))))};
        end
        set(handles.listbox1, 'String', err);
        legend({'Estimado','Error'});
    case 5
        set(handles.tono,'string',strcat('Emajor/C#minor'));
        set(handles.pnotas,'string','E F# G# A B C# D#');
        errorf=[32.7000 36.7100 43.6500 49.0000 58.2700];
        perror=errorfreq(freqn,errorf);
        axes(handles.axes2);
        hold on
        for i=1:1:size(perror')
            plot(t(1,perror(1,i)),freq(1,perror(1,i)),'ro');
            err(1,i)={strcat(num2str(t(1,perror(1,i))),'--',num2str(freq(1,perror(1,i))))};
        end
        set(handles.listbox1, 'String', err);
        legend({'Estimado','Error'});
    case 6
        set(handles.tono,'string',strcat('Fmajor/Dminor'));
        set(handles.pnotas,'string','F G A A# C D E');
        errorf=[34.6500 38.8900 46.2500 51.9100 61.7400];
        perror=errorfreq(freqn,errorf);
        axes(handles.axes2);
        hold on
        for i=1:1:size(perror')
            plot(t(1,perror(1,i)),freq(1,perror(1,i)),'ro');
            err(1,i)={strcat(num2str(t(1,perror(1,i))),'--',num2str(freq(1,perror(1,i))))};
        end
        set(handles.listbox1, 'String', err);
        legend({'Estimado','Error'});
    case 7
        set(handles.tono,'string',strcat('F#major/D#minor'));
        set(handles.pnotas,'string','F# G# A# B C# D# F');
        errorf=[32.7000 36.7100 41.2000 49.0000 55.0000];
        perror=errorfreq(freqn,errorf);
        axes(handles.axes2);
        hold on
        for i=1:1:size(perror')
            plot(t(1,perror(1,i)),freq(1,perror(1,i)),'ro');
            err(1,i)={strcat(num2str(t(1,perror(1,i))),'--',num2str(freq(1,perror(1,i))))};
        end
        set(handles.listbox1, 'String', err);
        legend({'Estimado','Error'});
    case 8
        set(handles.tono,'string',strcat('Gmajor/Eminor'));
        set(handles.pnotas,'string','G A B C D E F#');
        errorf=[34.6500 38.8900 43.6500 51.9100 58.2700];
        perror=errorfreq(freqn,errorf);
        axes(handles.axes2);
        hold on
        for i=1:1:size(perror')
            plot(t(1,perror(1,i)),freq(1,perror(1,i)),'ro');
            err(1,i)={strcat(num2str(t(1,perror(1,i))),'--',num2str(freq(1,perror(1,i))))};
        end
        set(handles.listbox1, 'String', err);
        legend({'Estimado','Error'});
    case 9
        set(handles.tono,'string',strcat('G#major/Fminor'));
        set(handles.pnotas,'string','G# A# C C# D# F G');
        errorf=[36.7100 41.2000 46.2500 55.0000 61.7400];
        perror=errorfreq(freqn,errorf);
        axes(handles.axes2);
        hold on
        for i=1:1:size(perror')
            plot(t(1,perror(1,i)),freq(1,perror(1,i)),'ro');
            err(1,i)={strcat(num2str(t(1,perror(1,i))),'--',num2str(freq(1,perror(1,i))))};
        end
        set(handles.listbox1, 'String', err);
        legend({'Estimado','Error'});
    case 10
        set(handles.tono,'string',strcat('Amajor/F#minor'));
        set(handles.pnotas,'string','A B C# D E F# G#');
        errorf=[32.7000 38.8900 43.6500 49.0000 58.2700];
        perror=errorfreq(freqn,errorf);
        axes(handles.axes2);
        hold on
        for i=1:1:size(perror')
            plot(t(1,perror(1,i)),freq(1,perror(1,i)),'ro');
            err(1,i)={strcat(num2str(t(1,perror(1,i))),'--',num2str(freq(1,perror(1,i))))};
        end
        set(handles.listbox1, 'String', err);
        legend({'Estimado','Error'});
    case 11
        set(handles.tono,'string',strcat('A#major/Gminor'));
        set(handles.pnotas,'string','A# C D D# F G A');
        errorf=[34.6500 41.2000 46.2500 51.9100 61.7400];
        perror=errorfreq(freqn,errorf);
        axes(handles.axes2);
        hold on
        for i=1:1:size(perror')
            plot(t(1,perror(1,i)),freq(1,perror(1,i)),'ro');
            err(1,i)={strcat(num2str(t(1,perror(1,i))),'--',num2str(freq(1,perror(1,i))))};
        end
        set(handles.listbox1, 'String', err);
        legend({'Estimado','Error'});
    case 12
        set(handles.tono,'string',strcat('Bmajor/G#minor'));
        set(handles.pnotas,'string','B C# D# E F# G# A#');
        errorf=[32.7000 36.7100 43.6500 49.0000 55.0000];
        perror=errorfreq(freqn,errorf);
        axes(handles.axes2);
        hold on
        for i=1:1:size(perror')
            plot(t(1,perror(1,i)),freq(1,perror(1,i)),'ro');
            err(1,i)={strcat(num2str(t(1,perror(1,i))),'--',num2str(freq(1,perror(1,i))))};
        end
        set(handles.listbox1, 'String', err);
        legend({'Estimado','Error'});
end
set(handles.pushbutton6,'enable','on');
set(handles.pushbutton7,'enable','on');


% --- Executes on slider movement.
function playslider_Callback(hObject, eventdata, handles)
% hObject    handle to playslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function playslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to playslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2);
zoom on;

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2);
pan on;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


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
