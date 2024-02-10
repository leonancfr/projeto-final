%Projeto Final - Estudo de um Conversor Full-Bridge com ZVS
%Universidade Federal do Rio de Janeiro
%Autor: Leonan Chicarelli de França
%Data: 08/02/2016

%Assunto: Cálculo dos componentes do circuito.
%ref: "ANALYSIS, DESIGN, AND IMPLEMENTATION OF A 5 KW ZERO VOLTAGE SWITCHING PHASE-SHIFTED FULL-BRIDGE DC/DC CONVERTER BASED POWER SUPPLY FOR ARC WELDING MACHINES"
%ref: "Design considerations for high-voltage high-power full-bridge zero-voltage-switching PWM converter"

clear; clc; close all;

Vin = 400;
Vprimario = Vin;
Vout = 48;
Iout = 50;
deltaIout = 0.2;%0.1;%melhor valor = 0.5
Ct = 100e-9;

% 1 - definir Dmax
Domax = 0.8; %Domax = 1 - 2*td*fs = 1-2*(1e-6)*(100e3)
Dzvs = 0.5;
% 2 - definir Vsec inicial
%Vsec = 400; %melhor valor %Vsec >= Vout/Domax
Vsec = 400;

n = Vprimario/Vsec;
Deff = (Vout/Vprimario) *(1/n);

% 3 - Definir ZVSrange, calcular Iocr e definir I2cr inicial
%ZVSrange = 55/100; %melhor valor %Definido arbitrariamente, a norma só faz teste de rendimento com carga nominal.
ZVSrange = 55/100;


Iocr = Iout* ZVSrange;
Ip2cr = Iocr * n;
%Ip2cr = 22.4163;
display(Ip2cr);


% 4 - Calcular Llk
Llk = Ct*(Vprimario^2)/(Ip2cr^2);

% 5 - Calcular fs
fs = (((n^2)*(Vout/Iout))/(4*Llk))*((Domax/Deff)-1);
Lout = (((Vprimario/n)-Vout)/(deltaIout))*(Deff/(2*fs));
Doutzvs = Domax/(1+((4*Llk)/((n^2)*(Vout/Iocr)*(1/fs))));

Ip2cr = (1/n)*(Iocr + deltaIout/2 - ((Vout/Lout)*(1-Dzvs)*(1/(2*fs))));
display(Ip2cr);

%novo valor de Llk
Llk = Ct*(Vprimario^2)/(Ip2cr^2);
fs = (((n^2)*(Vout/Iout))/(4*Llk))*((Domax/Deff)-1);
Lout = (((Vprimario/n)-Vout)/(deltaIout))*(Deff/(2*fs));
display(Llk);
display(fs);
display(Lout);









