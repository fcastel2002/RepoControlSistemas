#include <stdio.h>
#include <stdint.h>
#include <math.h>
#include <limits.h>
float fx2fp(int32_t fixed_val, uint8_t fractional_bits);
int32_t fp2fx(float fp_val, uint8_t fractional_bits);
int32_t truncation(int64_t X,uint8_t fractional_bits);
int32_t roundoff(int64_t X, uint8_t fractional_bits);
int32_t saturate_sum(int32_t a, int32_t b);