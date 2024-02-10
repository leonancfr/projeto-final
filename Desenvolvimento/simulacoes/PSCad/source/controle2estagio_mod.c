#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "C:\Users\Leo\Desktop\PSCad\halfBridge\halfbridge_completo_mayli\completo\sources\pidTransformadaZPontoFixo2_corrigido.h"

#define KP_VOLTAGE 10  //0.02 //Valor anterior = 0.2
#define INT_TIME_VOLTAGE 0.1       //Valor anterior = 0.1
#define KP_VOLTAGE_MOD 10//40
#define INT_TIME_VOLTAGE_MOD 0.015

#define KP_CURRENT_MOD 2//40
#define INT_TIME_CURRENT_MOD 1
#define KP_CURRENT 2     //melhor valor=2      //50
#define INT_TIME_CURRENT 0.0001//1

#define DT 20e-6
#define SIM_STEP 1e-6
#define KI_VOLTAGE (KP_VOLTAGE/INT_TIME_VOLTAGE)*DT
#define KI_VOLTAGE_MOD (KP_VOLTAGE_MOD/INT_TIME_VOLTAGE_MOD)*DT
#define KI_CURRENT (KP_CURRENT/INT_TIME_CURRENT)*DT
#define KI_CURRENT_MOD (KP_CURRENT_MOD/INT_TIME_CURRENT_MOD)*DT
#define KD_VOLTAGE 0
#define KD_CURRENT 0//0.05
#define VOLTAGE_REFERENCE 54
#define CURRENT_LIMIT 31.5
#define CURRENT_LIMIT_DELTA CURRENT_LIMIT+0
#define BACK_CALCULATION_CONSTANT_VOLTAGE 1000.0
#define BACK_CALCULATION_EFFECTIVE_VOLTAGE BACK_CALCULATION_CONSTANT_VOLTAGE*DT

#define MULTIPLO_MILIVOLT 3
#define FATOR_ARREDONDAMENTO 10000

pidFloatAntiWindupType controllerVoltage2;
pidFloatType controllerCurrent2;

float pidConstantsVoltage2[4], pidConstantsVoltage2_mod[4], pidConstantsCurrent2[3], pidConstantsCurrent2_mod[3];
int firstx = 1, firsty = 1;
long long unsigned counter2 = 0;
const int calcDelay2 = (int)(DT/SIM_STEP);
float saidaNaoSaturadaControladorTensao;
double currentLimit;
//double lastValue;

double arredondaNumero2(double leitura)
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

double geradorErrosADC2(double leitura)
{
    double temp;
    srand(clock());
    temp = leitura + (((double)(pow(-1,(rand()%2))*(rand()%9)))/(double)1000);
    //printf("temp: %f\n", temp);
    return arredondaNumero2(temp);
}

double modulo(double numero){
    if (numero >= 0)
        return numero;
    return -1.0*numero;
}

void out_control_hbridge_(double* vout, double* il, double* iRef, double* output, int* regDin)
{
    double auxvout, auxil, auxiRef;
    counter2++;

    auxvout = *vout;
    auxil = (*il)*30;
    auxvout = geradorErrosADC2(auxvout);
    auxil = geradorErrosADC2(auxil);
    auxil *= (500);
    auxil /= 30;
    //*iRef = auxil;
    //*output = 10;
    //return;

    if(firstx)
    {
        /*pidConstantsVoltage2[0] = KP_VOLTAGE;
        pidConstantsVoltage2[1] = KI_VOLTAGE;*/
        pidConstantsVoltage2[0] = KP_VOLTAGE;
        pidConstantsVoltage2[1] = KI_VOLTAGE;
        pidConstantsVoltage2[2] = KD_VOLTAGE;
        pidConstantsVoltage2[3] = BACK_CALCULATION_EFFECTIVE_VOLTAGE;
        pidConstantsVoltage2_mod[0] = KP_VOLTAGE_MOD;
        pidConstantsVoltage2_mod[1] = KI_VOLTAGE_MOD;
        pidConstantsVoltage2_mod[2] = KD_VOLTAGE;
        pidConstantsVoltage2_mod[3] = BACK_CALCULATION_EFFECTIVE_VOLTAGE;
        PIDFloatAntiWindupInit(&controllerVoltage2);
        PIDAntiWindupCoeffCalc(pidConstantsVoltage2_mod,&controllerVoltage2);
        controllerVoltage2.controlReference = VOLTAGE_REFERENCE;

        pidConstantsCurrent2[0] = KP_CURRENT;
        pidConstantsCurrent2[1] = KI_CURRENT;
        pidConstantsCurrent2[2] = KD_CURRENT;
        pidConstantsCurrent2_mod[0] = KP_CURRENT_MOD;
        pidConstantsCurrent2_mod[1] = KI_CURRENT_MOD;
        pidConstantsCurrent2_mod[2] = KD_CURRENT;
        PIDFloatInit(&controllerCurrent2);
        PIDFloatCoeffCalc(pidConstantsCurrent2_mod,&controllerCurrent2);
        currentLimit = CURRENT_LIMIT_DELTA;
    }
    firstx = 0;

    if ((((double)counter2 * SIM_STEP) >= 3.9000)&&(modulo(VOLTAGE_REFERENCE - auxvout) > 0.3)&&(firsty))
    {
        PIDAntiWindupCoeffCalc(pidConstantsVoltage2_mod,&controllerVoltage2);
        PIDFloatCoeffCalc(pidConstantsCurrent2_mod,&controllerCurrent2);
        currentLimit = CURRENT_LIMIT_DELTA;
        firsty = 0;
    }
    /*else{
            //PIDAntiWindupCoeffCalc(pidConstantsVoltage2,&controllerVoltage2);
            //  PIDFloatCoeffCalc(pidConstantsCurrent2,&controllerCurrent2);
            currentLimit = CURRENT_LIMIT_DELTA;
    }*/

    if (((double)counter2 * SIM_STEP) >= 8.0000)
        *regDin = 0;
    else if (((double)counter2 * SIM_STEP) >= 4.0000)
        *regDin = 1;
    else
        *regDin = 0;

    if (((double)counter2 * SIM_STEP) <= 0.2000)
    {
        *output = 0;
        return;
    }

    else if(!(counter2 % (calcDelay2)))
    //else if(!(counter2 % (20)))
    {

        controllerVoltage2.measuredOutput = auxvout;
        PIDFloatAntiWindup(&controllerVoltage2, currentLimit, 0, &saidaNaoSaturadaControladorTensao);
        //controllerVoltage2.controlOutput -= ((saturation_error[0] - saturation_error[1])*BACK_CALCULATION_EFFECTIVE_VOLTAGE);
        controllerCurrent2.controlReference = controllerVoltage2.controlOutput;

        *iRef = controllerVoltage2.controlOutput;

        controllerCurrent2.measuredOutput = auxil;
        PIDFloat(&controllerCurrent2);

        *output = controllerCurrent2.controlOutput;
    }

    //ss*output = 25;
    //printf("outputController = %.2f\n",*output);


}



