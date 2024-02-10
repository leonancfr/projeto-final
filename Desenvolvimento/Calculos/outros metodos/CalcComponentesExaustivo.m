%Projeto Final - Estudo de um Conversor Full-Bridge com ZVS
%Universidade Federal do Rio de Janeiro
%Autor: Leonan Chicarelli de França
%Data: 11/04/2016

%Assunto: Cálculo dos componentes do circuito no metodo exaustivo
%ref: "ANALYSIS, DESIGN, AND IMPLEMENTATION OF A 5 KW ZERO VOLTAGE SWITCHING PHASE-SHIFTED FULL-BRIDGE DC/DC CONVERTER BASED POWER SUPPLY FOR ARC WELDING MACHINES"
%ref: "Design considerations for high-voltage high-power full-bridge zero-voltage-switching PWM converter"

%-------------------
% Especificações
%-------------------
Vin = 400; %Tensão de entrada em V
Vout = 55; %Tensão de saída em V
Iout = 100; %Corrente de saída em A
fs = 50000; %Frequência de chaveamento
td = 0.0000009 %Valor de tempo-morto em segundo
Iocrmax = 35 %Maxima Corrente crítica de saída em A
Ippkmax = 28 %Maxima corrente de pico no primario do transformador em A

%-------------------
% Cálculos preliminares
%-------------------
domax=1-2*td*fs; % Step 1: Maximum primary duty cycle value
Nmax=(Vin*domax)/Vout; % Step 2: Maximum turns ratio value
Nmin=0.25*(Vin/Vout); % Step 3: Minimum turns ratio value
Nstep=(Nmax-Nmin)/100; % Turns ratio step size value utilized in the search
Ltmax=((Nmax*Vin)/(2*Iout))*(3/(8*fs)-td); % Step 4: Maximum Lt value
Ctmin=(1/Ltmax)*(((2*td)/pi)^2); % Step 5: Minimum Ct value
Ctmax=(1/(3e-6))*(((2*td)/pi)^2); % Step 6: Maximum Ct value
Cstep=(Ctmax-Ctmin)/200; % Ct step size value utilized in the search
Ro=Vout/Iout; % Load resistance value
n=0; % Initialize the convenient design parameter set number

%Loops utilized for the exhaustive search
for k=1:201;
    Ct=Ctmin+Cstep*(k-1); % Ct value for the corresponding search step
    Lt=(1/Ct)*(((2*td)/pi)^2); % Step 7: Lt value for the corresponding Ct
    for i=1:101;
        N=Nmin+Nstep*(i-1); % Turns ratio value for the corresponding search step
        %Step 8: Critical current value for the corresponding Lt and Ct
        Icr=(sqrt(Ct)*Vin)/(sqrt(Lt));
        %Step 9: Maximum doeff value for the corresponding search step
        doeffmax=domax/(1+((4*Lt*fs)/(N^2*Ro)));
        %Step 10: Design constraints given in (4.16), (4.17), and (4.18)
        if (doeffmax>((N*Vout)/Vin))
            if (((Iout/N)<Ippkmax)&(Icr<(Iocrmax/N)))
                %The design parameter set satisfies the constraints
                n=n+1; % Increment the convenient design parameter set number
                Lres(n)=Lt; % Store Lt value of the design parameter set
                Cres(n)=Ct; % Store Ct value of the design parameter set
                Nres(n)=N; % Store N value of the design parameter set
                Iocr(n)=N*Icr; % Store Iocr value for the corresponding design parameter set
                Ippk(n)=Iout/N; % Store Ippk value for the corresponding design parameter set
            end
        end
    end
end