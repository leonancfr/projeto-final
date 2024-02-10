#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "C:\Users\Leonan\Google Drive\UFRJ\Projeto Final\simulacoes\PSCad\source\pidTransformadaZPontoFixo2_corrigido.h"

#define KP_VOLTAGE 0.089 //melhor valor 0.08946 //primeiro valor = 0.9946
#define INT_TIME_VOLTAGE 3.45e-5 //melhor valor 2.95e-5 //primeiro valor = 0.0000295
#define KP_CURRENT 2.1 //melhor valor 2.1//primeiro valor = 3.488	
#define INT_TIME_CURRENT 8.94e-5 //melhor valor 8.94e-5 //primeiro valor = 0.0000148
#define DT 10e-6
#define SIM_STEP 0.1e-6

#define KI_VOLTAGE (KP_VOLTAGE/INT_TIME_VOLTAGE)*DT
#define KI_CURRENT (KP_CURRENT/INT_TIME_CURRENT)*DT
#define KD_VOLTAGE 0
#define KD_CURRENT 0

#define VOLTAGE_REFERENCE 48
#define CONSTANTE_LEITURA 1000

#define MULTIPLO_MILIVOLT 3
#define FATOR_ARREDONDAMENTO 10000

pidFloatType controllerVoltage2;
pidFloatType controllerCurrent2;

float pidConstantsVoltage2[3], pidConstantsCurrent2[3];
int first = 1;
long long unsigned counter = 0;

const int calcDelay = (int)(DT/SIM_STEP);

double arredondaNumero(double leitura)
{
    int leituraInt;
    leitura *= FATOR_ARREDONDAMENTO;
    leitura /= MULTIPLO_MILIVOLT;
    leituraInt = leitura;
    leituraInt *= MULTIPLO_MILIVOLT;
    if (leituraInt < 0)
        leituraInt = 0;
    return ((double)leituraInt)/FATOR_ARREDONDAMENTO;
}

double geradorErrosADC(double leitura)
{
    double temp;
    srand(clock());
    temp = leitura + (((double)(pow(-1,(rand()%2))*(rand()%9)))/(double)1000);
    return arredondaNumero(temp);
}

void out_control_hbridge_(double* vout, double* il, double* iRef, double* output, double* referencia)
{
    
	double auxvout, auxil;
	auxvout = CONSTANTE_LEITURA * (*vout);
	auxil = CONSTANTE_LEITURA * (*il);
	auxvout = geradorErrosADC(auxvout);
    auxil = geradorErrosADC(auxil);
	
	if(first){
        pidConstantsVoltage2[0] = KP_VOLTAGE;
		pidConstantsVoltage2[1] = KI_VOLTAGE;
		pidConstantsVoltage2[2] = KD_VOLTAGE;
        PIDFloatInit(&controllerVoltage2);
        PIDFloatCoeffCalc(pidConstantsVoltage2,&controllerVoltage2);
        controllerVoltage2.controlReference = *referencia;

        pidConstantsCurrent2[0] = KP_CURRENT;
		pidConstantsCurrent2[1] = KI_CURRENT;
		pidConstantsCurrent2[2] = KD_CURRENT;
        PIDFloatInit(&controllerCurrent2);
        PIDFloatCoeffCalc(pidConstantsCurrent2,&controllerCurrent2);
    }
    first = 0;
	
	if (!(counter%calcDelay))
	{
		controllerVoltage2.measuredOutput = (auxvout);
		PIDFloat(&controllerVoltage2);

		if (controllerVoltage2.controlOutput > 10.0) //saturando o PID
			controllerVoltage2.controlOutput = 10.0;
		if (controllerVoltage2.controlOutput < 0.0) //saturando o PID
			controllerVoltage2.controlOutput = 0.0;
	
		controllerCurrent2.controlReference = controllerVoltage2.controlOutput;
		*iRef = controllerVoltage2.controlOutput;
	
		controllerCurrent2.measuredOutput = (auxil);
		PIDFloat(&controllerCurrent2);

		if (controllerCurrent2.controlOutput > 3.3) ////saturando o PID
			controllerCurrent2.controlOutput = 3.3;
		if (controllerCurrent2.controlOutput < 0.0) //saturando o PID
			controllerCurrent2.controlOutput = 0.0;
	}
	
    *output = controllerCurrent2.controlOutput;
	
	
	counter++;
}



