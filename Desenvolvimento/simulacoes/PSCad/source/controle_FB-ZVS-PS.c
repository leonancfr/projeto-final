#include <stdio.h>
#include <stdlib.h>
#include "C:\Users\Leonan\Google Drive\UFRJ\Projeto Final\simulacoes\PSCad\source\pidTransformadaZPontoFixo2_corrigido.h"

#define KP_VOLTAGE 0.9946 //0.9946
#define INT_TIME_VOLTAGE 0.0000295 //0.0000295
#define KP_CURRENT 3.488 //melhor valor = 2.3 //3.488	
#define INT_TIME_CURRENT 0.0000148 //melhor valor = 9.79e-6 //0.0000148
#define DT 0.1e-6
#define KI_VOLTAGE (KP_VOLTAGE/INT_TIME_VOLTAGE)*DT
#define KI_CURRENT (KP_CURRENT/INT_TIME_CURRENT)*DT
#define KD_VOLTAGE 0
#define KD_CURRENT 0
#define VOLTAGE_REFERENCE 48
#define CONSTANTE_LEITURA 1000

pidFloatType controllerVoltage2;
pidFloatType controllerCurrent2;

float pidConstantsVoltage2[3], pidConstantsCurrent2[3];
int first = 1;
long long unsigned counter = 0;

void out_control_hbridge_(double* vout, double* il, double* iRef, double* output, double* referencia)
{
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
	//if(counter == 100)
	//	counter = 0;
	//if(((((double)counter)*DT)/(10e-6)) == 0){
	//if(counter == 0){
	controllerVoltage2.measuredOutput = (*vout)*CONSTANTE_LEITURA;
	PIDFloat(&controllerVoltage2);

	if (controllerVoltage2.controlOutput > 10.0) //saturando o PID
		controllerVoltage2.controlOutput = 10.0;
	if (controllerVoltage2.controlOutput < 0.0) //saturando o PID
		controllerVoltage2.controlOutput = 0.0;
	
	controllerCurrent2.controlReference = controllerVoltage2.controlOutput;
	*iRef = controllerVoltage2.controlOutput;
	
	controllerCurrent2.measuredOutput = (*il)*CONSTANTE_LEITURA;
	PIDFloat(&controllerCurrent2);

	if (controllerCurrent2.controlOutput > 3.3) ////saturando o PID
        controllerCurrent2.controlOutput = 3.3;
    if (controllerCurrent2.controlOutput < 0.0) //saturando o PID
        controllerCurrent2.controlOutput = 0.0;
	
	//}
    *output = controllerCurrent2.controlOutput;
	counter++;
}



