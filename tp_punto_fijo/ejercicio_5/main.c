#include <stdio.h>
#include "fixed_point_util.h"
int main(void) {
    float X[5] = {1.1, 2.2, -3.3, 4.4, -5.5};
    float Y[5] = {6.6, -7.7, 8.8, -9.9, 10.10};
    int32_t X_fixed[5];
    int32_t Y_fixed[5];
    for (int i = 0; i < 5; i++) {
        X_fixed[i] = fp2fx(X[i],10);
        Y_fixed[i] = fp2fx(Y[i],10);
    }
    // 3.
    int32_t acum_32a = 0;
    int64_t acum_64 = 0;
    int32_t acum_32b = 0;
    for(int i = 0; i < 5; i++) {
        acum_32a += (int32_t)(roundoff((int64_t)(X_fixed[i] * Y_fixed[i]), 10));
        acum_64 += (int64_t)(X_fixed[i] * Y_fixed[i]);
    }
    acum_32b = roundoff(acum_64, 10);
    // 4.
    double X_db[5] = {1.1, 2.2, -3.3, 4.4, -5.5};
    double Y_db[5] = {6.6, -7.7, 8.8, -9.9, 10.10};
    double acum_double = 0;
    for(int i = 0; i < 5; i++){
        acum_double += X_db[i] * Y_db[i];
    }
    // Comparacion de resultados
    
    printf("Acumulador de 32 bits con truncamiento (entero): %d\n", acum_32a);
    printf("Acumulador de 32 bits con acumulacion en 64 bits (entero): %d\n", acum_32b);
    printf("Acumulador de 32 bits con truncamiento (float): %f\n", fx2fp(acum_32a, 10));
    printf("Acumulador de 32 bits con acumulacion en 64 bits (float): %f\n", fx2fp(acum_32b, 10));
    printf("Acumulador de punto flotante: %f\n", acum_double);
    printf("\nErrores:\n");
    printf("Error truncamiento 32 bits: %f\n", fabsf(acum_double - fx2fp(acum_32a, 10)));
    printf("Error acumulacion 64 bits: %f\n", fabsf(acum_double - fx2fp(acum_32b, 10)));
    
    return 0;
}