#include <stdio.h>
#include <stdint.h>
#include <math.h>
float fx2fp(int32_t fixed_val, uint8_t fractional_bits){
    float scale_factor = (float)(1ULL    << fractional_bits); // obtenemos 2^Q y usamos 1ULL para poder usar Q31
    return (float)fixed_val / scale_factor;
}

int32_t fp2fx(float fp_val, uint8_t fractional_bits){
    float scale_factor = (float)(1ULL << fractional_bits);
    return (int32_t)(fp_val * scale_factor);
}
void main(void){
    float res_Q23_8 = fx2fp(fp2fx(2.4515,8),8);
    float res_Q21_10 = fx2fp(fp2fx(2.4515,16),16);  
    printf("Q23.8: %f\n", res_Q23_8);
    printf("Q21.10: %f\n", res_Q21_10);
    
}