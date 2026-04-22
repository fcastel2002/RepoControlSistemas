function varargout = pruebasonido(varargin)
% PRUEBASONIDO MATLAB code for pruebasonido.fig
%      PRUEBASONIDO, by itself, creates a new PRUEBASONIDO or raises the existing
%      singleton*.
%
%      H = PRUEBASONIDO returns the handle to a new PRUEBASONIDO or the handle to
%      the existing singleton*.
%
%      PRUEBASONIDO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRUEBASONIDO.M with the given input arguments.
%
%      PRUEBASONIDO('Property','Value',...) creates a new PRUEBASONIDO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pruebasonido_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pruebasonido_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pruebasonido

% Last Modified by GUIDE v2.5 09-Oct-2015 18:00:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pruebasonido_OpeningFcn, ...
                   'gui_OutputFcn',  @pruebasonido_OutputFcn, ...
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


% --- Executes just before pruebasonido is made visible.
function pruebasonido_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Creamos nuestra estructura myGui
myGui = handles; 

% varargin{1} será el array, varargin{2} será la frecuencia
% Verificamos que hay al menos 2 parámetros numéricos
if length(varargin) >= 2 && isnumeric(varargin{1}) && isnumeric(varargin{2})
    
    myGui.datasound = varargin{1};
    myGui.freqSam = double(varargin{2}); 
    myGui.player = audioplayer(myGui.datasound, myGui.freqSam);
    myGui.flag = 2; 
    
    % --- NUEVO: Manejo del Título ---
    % Si hay un tercer parámetro y es texto (char o string)
    if length(varargin) >= 3 && (ischar(varargin{3}) || isstring(varargin{3}))
        mi_titulo = char(varargin{3});
    else
        mi_titulo = 'Reproductor de MATLAB'; % Nombre por defecto si no le pasas título
    end
    
    % Cambiamos el nombre de la ventana y ocultamos el "Figure 1"
    set(hObject, 'Name', mi_titulo, 'NumberTitle', 'off'); 
    
    % Actualizamos el texto dentro de la GUI para que también lo muestre
    set(handles.text3, 'String', ['Listo: ' mi_titulo]);
    
else
    % Qué hacer si se abre sin datos
    set(handles.text3, 'String', 'Esperando datos...');
    set(hObject, 'Name', 'Reproductor Vacío', 'NumberTitle', 'off');
    myGui.flag = 0;
end

% MUY IMPORTANTE: Guardamos los datos en la figura
guidata(hObject, myGui);

% --- Outputs from this function are returned to the command line.
function varargout = pruebasonido_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);
[file,path] = uigetfile('*.wav','Seleccione un archivo de sonido');
[x,fs] = audioread([path file]);
myGui.freqSam=fs;
myGui.datasound=x;
myGui.player=audioplayer(myGui.datasound,myGui.freqSam);
myGui.flag=2;
set(handles.text3,'String',[path file]);
guidata(handles.figure1,myGui)


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);
if(myGui.flag==2)
    myGui.flag=1;
    disp('2');
    play(myGui.player);
else
    if(myGui.flag == 1)
        disp('1');
        myGui.flag=0;
        pause(myGui.player);
    else
        disp('0');
        myGui.flag=1;
        resume(myGui.player)
    end
end
guidata(handles.figure1,myGui);

% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
myGui=guidata(handles.figure1);
myGui.flag=2;
stop(myGui.player);
guidata(handles.figure1,myGui);
