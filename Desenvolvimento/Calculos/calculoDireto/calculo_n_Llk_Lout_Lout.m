%Projeto Final - Estudo de um Conversor Full-Bridge com ZVS
%Universidade Federal do Rio de Janeiro
%Autor: Leonan Chicarelli de Fran�a
%Data: 24/04/2016

%Assunto: C�lculo dos componentes do circuito diretamente
%C�lculo de:
%           -rela��o de espiras
%           -numero minimo de espiras do primario
%           -Indutor de dispers�o
%           -Indutor do filtro de sa�da
%           -Capacitor do filtro de sa�da
%           O projeto do transformador e dos indutores � feito a parte
%ref: "AN�LISE E PROJETO DE COMPENSADORES PARA CONVERSORES FULL-BRIDGE - ZVS - PWM - PS"
%ref: "UNIDADE RETIFICADORA DE ALTA PERFORIVI�NCE 1500W - 25A, PARA TELECOMUNICA��ES"
clear; clc; close all;

%ESPECIFICA��ES
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

PoutMax = VoutMax * Iout; %W - Pot�ncia m�xima de sa�da
PinMax = PoutMax / Eficiencia; %W - Pot�ncia m�xima de entrada;

% 1 - Rela��o de transforma��o

alpha = (Eficiencia * (VinMin - 2*Vdson) * DefMax)/(VoutMax + Vf);
%%alpha = round(alpha); %alpha = Np/Ns
n = 1/alpha;

% 2 - INDUTOR RESSONANTE

    % a - Determina��o da indutancia Llk

deltaD = 0.02; % 2% de perda de razao ciclica - essa perda tem rela��o com o tempo que o sinal de acionamento das chaves demora(atraso) pra ir de um n�vel a outro. (deltaD = deltaT/(Ts/2)) no caso deltaT seria (1/120MHz), mas coloquei 100ns pra uma folga
Llk = (deltaD * VinMin)/(4 * Fs * n * Iout);

% 3 - INDUTOR DO FILTRO DE SA�DA - Lout

DefMin = n*(VoutMin + Vf)/VinMax;
deltaILout = 0.1*Iout;
Lout = ((VoutMax + Vf)*(1-DefMin))/(2*Fs*deltaILout);

% 4 - CAPACITOR DO FILTRO DE SA�DA - Cout

Cout = deltaILout/(8 * Fs * Ripple);
RcoutMax = Ripple/deltaILout;


n
Llk
Lout
Cout

    
    
    
