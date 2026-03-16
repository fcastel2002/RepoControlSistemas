#include "fixed_point_util.h"

float fx2fp(int32_t fixed_val, uint8_t fractional_bits){
    float scale_factor = (float)(1ULL << fractional_bits);
    return (float)fixed_val / scale_factor;
}

int32_t fp2fx(float fp_val, uint8_t fractional_bits){
    float scale_factor = (float)(1ULL << fractional_bits);
    return (int32_t)(fp_val * scale_factor);
}