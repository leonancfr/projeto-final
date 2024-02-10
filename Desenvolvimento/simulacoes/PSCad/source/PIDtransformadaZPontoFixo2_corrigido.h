#ifndef PIDTRANSFORMADAZPONTOFIXO2_CORRIGIDO_H_INCLUDED
#define PIDTRANSFORMADAZPONTOFIXO2_CORRIGIDO_H_INCLUDED

#include <stdint.h>

#define Q 15
#define K (1<<(Q-1))
#define Q_CONVERSION 32768
#define Q_CONVERSION_INVERSE (1/32768.0)

typedef int16_t fractional;
typedef int32_t longFractional;
typedef struct {
    fractional abcCoefficients[3];
    fractional controlHistory[3];
    fractional controlOutput;
    fractional previousOutput;
    fractional measuredOutput;
    fractional controlReference;
}pidType;

typedef struct{
    float abcCoefficients[3];
    float controlHistory[3];
    float controlOutput;
    float previousOutput;
    float measuredOutput;
    float controlReference;
}pidFloatType;

void PIDInit(pidType *pidStruct);
void PIDFloatInit(pidFloatType *pidStruct);
void PIDCoeffCalc(fractional *pidConstants, pidType *pidStruct);
void PIDFloatCoeffCalc(float *pidConstants, pidFloatType *pidStruct);
void PIDCoeffCalcSatSum(fractional *pidConstants, pidType *pidStruct);
void PID(pidType *pidStruct);
void PIDFloat(pidFloatType *pidStruct);

fractional mul(fractional a, fractional b);
fractional sum(fractional a, fractional b);
fractional float2fract(float);
float fract2float(fractional);

#endif // PIDTRANSFORMADAZPONTOFIXO2_CORRIGIDO_H_INCLUDED
