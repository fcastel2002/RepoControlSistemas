#ifndef FIXED_POINT_UTIL_H
#define FIXED_POINT_UTIL_H

#include <stdint.h>

float fx2fp(int32_t fixed_val, uint8_t fractional_bits);
int32_t fp2fx(float fp_val, uint8_t fractional_bits);

#endif