%Projeto Final - Estudo de um Conversor Full-Bridge com ZVS
%Universidade Federal do Rio de Janeiro
%Autor: Leonan Chicarelli de França
%Data: 24/04/2016

%Assunto: Cálculo dos componentes do circuito diretamente
%Cálculo de:
%           -relação de espiras
%           -numero minimo de espiras do primario
%           -Indutor de dispersão
%           -Indutor do filtro de saída
%           -Capacitor do filtro de saída
%           O projeto do transformador e dos indutores é feito a parte
%ref: "ANÁLISE E PROJETO DE COMPENSADORES PARA CONVERSORES FULL-BRIDGE - ZVS - PWM - PS"
%ref: "UNIDADE RETIFICADORA DE ALTA PERFORIVIÀNCE 1500W - 25A, PARA TELECOMUNICAÇÕES"
clear; clc; close all;

%ESPECIFICAÇÕES
VoutMin = 48;%V
VoutMax = 59;%V
Iout = 10;%A
VinMax = 410;%V
Vin = 400;%V
VinMin = 390;%V
Fs = 100000;%Hz
Ripple = 0.2;
Eficiencia = 95/100;


Vf = 1; %V - queda nos didos retificadores
Vdson = 2;
DefMax =  0.8;

PoutMax = VoutMax * Iout; %W - Potência máxima de saída
PinMax = PoutMax / Eficiencia; %W - Potência máxima de entrada;

% 1 - Relação de transformação

alpha = (Eficiencia * (VinMin - 2*Vdson) * DefMax)/(VoutMax + Vf);
%%alpha = round(alpha); %alpha = Np/Ns
n = 1/alpha;

% 2 - INDUTOR RESSONANTE

    % a - Determinação da indutancia Llk

deltaD = 0.02; % 2% de perda de razao ciclica - essa perda tem relação com o tempo que o sinal de acionamento das chaves demora(atraso) pra ir de um nível a outro. (deltaD = deltaT/(Ts/2)) no caso deltaT seria (1/120MHz), mas coloquei 100ns pra uma folga
Llk = (deltaD * VinMin)/(4 * Fs * n * Iout);

% 3 - INDUTOR DO FILTRO DE SAÍDA - Lout

DefMin = n*(VoutMin + Vf)/VinMax;
deltaILout = 0.1*Iout;
Lout = ((VoutMax + Vf)*(1-DefMin))/(2*Fs*deltaILout);

% 4 - CAPACITOR DO FILTRO DE SAÍDA - Cout

Cout = deltaILout/(8 * Fs * Ripple);
RcoutMax = Ripple/deltaILout;


n
Llk
Lout
Cout

    
    
    
