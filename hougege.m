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