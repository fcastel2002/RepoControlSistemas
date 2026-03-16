#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include "fixed_point_util.h"

int main(void){
    float res_Q23_8 = fx2fp(fp2fx(2.4515,8),8);
    float res_Q21_10 = fx2fp(fp2fx(2.4515,16),16);  
    printf("Q23.8: %f\n", res_Q23_8);
    printf("Q21.10: %f\n", res_Q21_10);

    return 0;
}