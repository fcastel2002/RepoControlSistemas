#include "fixed_point_util.h"
#include <stdio.h>
#include <stdint.h>

int main(void){
    int32_t a = 2040021584;
    int32_t b = 312310293;
    int32_t sum = saturate_sum(a, b);
    printf("INT32 MAX: %d\n", INT32_MAX);
    printf("Saturate sum of %d and %d is: %d\n", a, b, sum);
    return 0;
}