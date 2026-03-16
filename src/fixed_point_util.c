#include "../include/fixed_point_util.h"
float fx2fp(int32_t fixed_val, uint8_t fractional_bits){
    float scale_factor = (float)(1ULL    << fractional_bits); // obtenemos 2^Q y usamos 1ULL para poder usar Q31
    return (float)fixed_val / scale_factor;
}

int32_t fp2fx(float fp_val, uint8_t fractional_bits){
    float scale_factor = (float)(1ULL << fractional_bits);
    return (int32_t)(fp_val * scale_factor);
}
int32_t truncation(int64_t X, uint8_t fractional_bits){
    int32_t result = (int32_t)(X >> fractional_bits);
    return result;
}
int32_t roundoff(int64_t X, uint8_t fractional_bits){
    int32_t result;
    result = X + (1 << (fractional_bits - 1));
    return truncation(result, fractional_bits);
}
int32_t saturate_sum(int32_t a, int32_t b){
    // pensada para una cpu que no pueda manejar 64 bits.
    if(b > 0 && a > INT32_MAX - b){
        return INT32_MAX;
    } else if (b < 0 && a < INT32_MIN - b){
        return INT32_MIN;
    } else {
        return a + b;
    }
}