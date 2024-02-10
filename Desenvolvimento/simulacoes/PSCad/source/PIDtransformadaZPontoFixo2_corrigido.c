#include <stdio.h>
#include <stdlib.h>
#include "C:\Users\Leonan\Google Drive\UFRJ\Projeto Final\simulacoes\PSCad\source\pidTransformadaZPontoFixo2_corrigido.h"

fractional mul(fractional a, fractional b)
{
    longFractional temp;
    temp = (longFractional)a * (longFractional)b;
    temp+=K;
    return temp >> Q;
}

fractional sum(fractional a, fractional b){
    fractional temp = a+b;
    if ((a > 0)&&(b > 0)&&(temp < 0))
        return 0x7FFF;
    if ((a < 0)&&(b < 0)&&(temp > 0))
        return 0x8000;
    return temp;
}

fractional float2fract(float a)
{
    if (a<0)
        return (a*Q_CONVERSION)-0.5;
    return (a*Q_CONVERSION)+0.5;
}
float fract2float(fractional a)
{
    return a*Q_CONVERSION_INVERSE;
}

void PIDInit(pidType *pidStruct)
{
    pidStruct->controlHistory[0] = 0;
    pidStruct->controlHistory[1] = 0;
    pidStruct->controlHistory[2] = 0;
    pidStruct->controlOutput = 0;
    pidStruct->previousOutput = 0;
}

void PIDFloatInit(pidFloatType *pidStruct)
{
    pidStruct->controlHistory[0] = 0;
    pidStruct->controlHistory[1] = 0;
    pidStruct->controlHistory[2] = 0;
    pidStruct->controlOutput = 0;
    pidStruct->previousOutput = 0;
}

void PIDCoeffCalc(fractional *pidConstants, pidType *pidStruct)
{
    pidStruct->abcCoefficients[0] = pidConstants[0]+pidConstants[1]+pidConstants[2];
    pidStruct->abcCoefficients[1] = -1*(pidConstants[0] + (fractional)(2*pidConstants[2]));
    pidStruct->abcCoefficients[2] = pidConstants[2];
    pidStruct->controlOutput = 0;
    pidStruct->previousOutput = 0;

}

void PIDFloatCoeffCalc(float *pidConstants, pidFloatType *pidStruct)
{
    pidStruct->abcCoefficients[0] = pidConstants[0]+pidConstants[1]+pidConstants[2];
    pidStruct->abcCoefficients[1] = -1*(pidConstants[0] + (2*pidConstants[2]));
    pidStruct->abcCoefficients[2] = pidConstants[2];
    pidStruct->controlOutput = 0;
    pidStruct->previousOutput = 0;
}

void PIDCoeffCalcSatSum(fractional *pidConstants, pidType *pidStruct)
{
    pidStruct->abcCoefficients[0] = sum(sum(pidConstants[0],pidConstants[1]),pidConstants[2]);
    pidStruct->abcCoefficients[1] = -1*(sum(pidConstants[0] , (fractional)(2*pidConstants[2])));
    pidStruct->abcCoefficients[2] = pidConstants[2];
    pidStruct->controlOutput = 0;
    pidStruct->previousOutput = 0;

}

void PID(pidType *pidStruct)
{
    //pidStruct->controlHistory[0] = pidStruct->measuredOutput - pidStruct->controlReference;        //De acordo com o manual da função. Pra mim o certo eh o contrário.
    pidStruct->controlHistory[0] = pidStruct->controlReference - pidStruct->measuredOutput;
    pidStruct->controlOutput =  pidStruct->previousOutput +
            mul(pidStruct->controlHistory[0],pidStruct->abcCoefficients[0]) +
            mul(pidStruct->controlHistory[1],pidStruct->abcCoefficients[1]) +
            mul(pidStruct->controlHistory[2],pidStruct->abcCoefficients[2]);

    pidStruct->previousOutput = pidStruct->controlOutput;
    pidStruct->controlHistory[2] = pidStruct->controlHistory[1];
    pidStruct->controlHistory[1] = pidStruct->controlHistory[0];
}

void PIDFloat(pidFloatType *pidStruct)
{
    //pidStruct->controlHistory[0] = pidStruct->measuredOutput - pidStruct->controlReference;        //De acordo com o manual da função. Pra mim o certo eh o contrário.
    pidStruct->controlHistory[0] = pidStruct->controlReference - pidStruct->measuredOutput;
    pidStruct->controlOutput =  (pidStruct->previousOutput) +
            (pidStruct->controlHistory[0]*pidStruct->abcCoefficients[0]) +
            (pidStruct->controlHistory[1]*pidStruct->abcCoefficients[1]) +
            (pidStruct->controlHistory[2]*pidStruct->abcCoefficients[2]);

    pidStruct->previousOutput = pidStruct->controlOutput;
    pidStruct->controlHistory[2] = pidStruct->controlHistory[1];
    pidStruct->controlHistory[1] = pidStruct->controlHistory[0];
}

void PIDSatSum(pidType *pidStruct)
{
    //pidStruct->controlHistory[0] = pidStruct->measuredOutput - pidStruct->controlReference;        //De acordo com o manual da função. Pra mim o certo eh o contrário.
    pidStruct->controlHistory[0] = pidStruct->controlReference - pidStruct->measuredOutput;
    pidStruct->controlOutput =  pidStruct->previousOutput +
            mul(pidStruct->controlHistory[0],pidStruct->abcCoefficients[0]) +
            mul(pidStruct->controlHistory[1],pidStruct->abcCoefficients[1]) +
            mul(pidStruct->controlHistory[2],pidStruct->abcCoefficients[2]);

    pidStruct->previousOutput = pidStruct->controlOutput;
    pidStruct->controlHistory[2] = pidStruct->controlHistory[1];
    pidStruct->controlHistory[1] = pidStruct->controlHistory[0];
}

