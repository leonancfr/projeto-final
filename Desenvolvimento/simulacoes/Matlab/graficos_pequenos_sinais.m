%Projeto Final - Estudo de um Conversor Full-Bridge com ZVS
%Universidade Federal do Rio de Janeiro
%Autor: Leonan Chicarelli de França
%Data: 02/05/2016

%Assunto: Funções de transferência de interesse para o controle (continua e discreta)
%           Gráficos de módulo e fase das funções de transferência
clear; clc; close all;

%Valores
Vin = 400;
n = 0.2;
Cout = 6.25e-6; 
Lout = 292.83e-6;
RL = 4.8;
Llk = 9.5342e-6;
Fs = 100e3;
Rd = 4*n^2*Llk*Fs;

% ilout/d
num1s = [n*Vin*Cout*RL n*Vin];
den1s = [Cout*Lout*RL Lout+Cout*Rd RL+Rd];

H1s = tf(num1s,den1s)

figure(1);
bode(H1s);

% [num1z den1z] = bilinear(num1s,den1s,Fs);
% 
% H1z = tf(num1z,den1z,Fs)
% fvtool(num1z,den1z);

%vout/ilout
num2s = [RL];
den2s = [Cout*RL 1];

figure(3);
H2s = tf(num2s,den2s)
bode(H2s);

% [num2z den2z] = bilinear(num2s,den2s,Fs);
% 
% H2z = tf(num2z,den2z,Fs)
% fvtool(num2z,den2z);

syms kpi kii kpv kiv
numC1s = [kpi kii];
denC1s = [1];
C1s = tf(numC1s,denC1s);

numC2s = [kpv kiv];
denC2s = [1];
C2s = tf(numC2s,denC2s);

TCL = H1s*C1s/3.3;

TVL = H2s*C2s*16;
