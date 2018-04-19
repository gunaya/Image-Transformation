function varargout = modul3(varargin)
% MODUL3 MATLAB code for modul3.fig
%      MODUL3, by itself, creates a new MODUL3 or raises the existing
%      singleton*.
%
%      H = MODUL3 returns the handle to a new MODUL3 or the handle to
%      the existing singleton*.
%
%      MODUL3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MODUL3.M with the given input arguments.
%
%      MODUL3('Property','Value',...) creates a new MODUL3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before modul3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to modul3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help modul3

% Last Modified by GUIDE v2.5 13-Apr-2018 16:04:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @modul3_OpeningFcn, ...
                   'gui_OutputFcn',  @modul3_OutputFcn, ...
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


% --- Executes just before modul3 is made visible.
function modul3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to modul3 (see VARARGIN)

% Choose default command line output for modul3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes modul3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = modul3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buttonOpen.
function buttonOpen_Callback(hObject, eventdata, handles)
% hObject    handle to buttonOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [filename, pathname] = uigetfile({'*.jpg';'*.bmp'},'File Selector');
    handles.gambar = imread(strcat(pathname, filename));    
    axes(handles.axesAsli);
    imshow(handles.gambar);
    setappdata(handles.buttonOpen,'gambarsaved',handles.gambar);
    
    guidata(hObject, handles);

% --- Executes on button press in DFT.
function DFT_Callback(hObject, eventdata, handles)
% hObject    handle to DFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambar = getappdata(handles.buttonOpen,'gambarsaved');
    gambarGrey = rgb2gray(gambar);
    gambarGrey = im2double(gambarGrey);
    gambarTr = fft(gambarGrey);
    gambarDFT = fftshift(gambarTr);
    handles.gambarDFT = log(abs(gambarDFT));
    axes(handles.axes_transform);
    imshow(handles.gambarDFT,[]);

    setappdata(handles.DFT, 'gambarDFT',gambarTr);


% --- Executes on button press in DCT.
function DCT_Callback(hObject, eventdata, handles)
% hObject    handle to DCT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambar = getappdata(handles.buttonOpen,'gambarsaved');
    gambarGray = rgb2gray(gambar);
    handles.gambarDCT = dct2(gambarGray);

    %colormap(gca,jet(64));
    axes(handles.axes_transform);
    imshow(log(abs(handles.gambarDCT)),[]);

    setappdata(handles.DCT, 'gambarDCT', handles.gambarDCT);

% --- Executes on button press in FFT.
function FFT_Callback(hObject, eventdata, handles)
% hObject    handle to FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambar = getappdata(handles.buttonOpen,'gambarsaved');
    gambarGrey = rgb2gray(gambar);
    gambarGrey = im2double(gambarGrey);
    gambarTr = fft2(gambarGrey);
    gambarDFT = fftshift(gambarTr);
    handles.gambarDFT = log(abs(gambarDFT));
    axes(handles.axes_transform);
    imshow(handles.gambarDFT,[]);

    setappdata(handles.FFT, 'gambarFFT',gambarTr);

% --- Executes on button press in Wavelet.
function Wavelet_Callback(hObject, eventdata, handles)
% hObject    handle to Wavelet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambar = getappdata(handles.buttonOpen,'gambarsaved');
    gambarGrey = rgb2gray(gambar);
    [cA,cH,cV,cD] = dwt2(gambarGrey,'sym4');
    axes(handles.axes_transform);
    imagesc(cA);
    %subplot(2,2,1), imagesc(cA);
    %subplot(2,2,2), imagesc(cH);
    %subplot(2,2,3), imagesc(cV);
    %subplot(2,2,4), imagesc(cD);

    setappdata(handles.Wavelet, 'cA',cA);
    setappdata(handles.Wavelet, 'cH',cH);
    setappdata(handles.Wavelet, 'cV',cV);
    setappdata(handles.Wavelet, 'cD',cD);

% --- Executes on button press in InversDFT.
function InversDFT_Callback(hObject, eventdata, handles)
% hObject    handle to InversDFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambarDFT = getappdata(handles.DFT,'gambarDFT');

    %magfft=abs(gambarDFT);
    %phasefft=angle(gambarDFT);
    %imafterfft=abs(ifft(magfft.*exp(i*phasefft)));
    imAfterfft = ifft(gambarDFT);
    axes(handles.axes_invers);
    imshow(imAfterfft);

% --- Executes on button press in InversDCT.
function InversDCT_Callback(hObject, eventdata, handles)
% hObject    handle to InversDCT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambarDCT = getappdata(handles.DCT, 'gambarDCT');

    gambarInvDCT = idct2(gambarDCT)/255;
    axes(handles.axes_invers);
    imshow(gambarInvDCT);

% --- Executes on button press in InversFFT.
function InversFFT_Callback(hObject, eventdata, handles)
% hObject    handle to InversFFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambarFFT = getappdata(handles.FFT,'gambarFFT');

    magfft2=abs(gambarFFT);
    phasefft2=angle(gambarFFT);
    imafterfft2=abs(ifft2(magfft2.*exp(i*phasefft2)));
    % imafterfft2 = ifft2(gambarFFT);
    axes(handles.axes_invers);
    imshow(imafterfft2);

% --- Executes on button press in InversWavelet.
function InversWavelet_Callback(hObject, eventdata, handles)
% hObject    handle to InversWavelet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    gambar = getappdata(handles.buttonOpen,'gambarsaved');
    sX = size(gambar);
    cA = getappdata(handles.Wavelet, 'cA');
    cH = getappdata(handles.Wavelet, 'cH');
    cV = getappdata(handles.Wavelet, 'cV');
    cD = getappdata(handles.Wavelet, 'cD');

    InvWavelet = idwt2(cA,cH,cV,cD,'sym4',sX);
    axes(handles.axes_invers);
    imagesc(InvWavelet);

% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    close;


% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    axes(handles.axes_invers);
    cla(handles.axes_invers);