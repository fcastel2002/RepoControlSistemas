#include <stdio.h>
#include <stdint.h>
#include "fixed_point_util.h"
// Para multiplicar dos numeros en formato punto fijo podemos 
// aprovecharnos de las funciones que definimos previamente


int main(void){
    double a = 21.141516001381291923;
    double b = 5.718281139839821981;
    int32_t a_fx = fp2fx(a,10);
    int32_t b_fx = fp2fx(b,10);
    printf("a (fp): %f, a (fx): %d\n", a, a_fx);
    printf("b (fp): %f, b (fx): %d\n", b, b_fx);
    int64_t product_fx = (int64_t)a_fx * (int64_t)b_fx;
    int32_t result_fx_truncated = truncation(product_fx, 10);
    int32_t result_fx_rounded = roundoff(product_fx, 10);
    float result_fp_truncated = fx2fp(result_fx_truncated, 10);
    float result_fp_rounded = fx2fp(result_fx_rounded, 10);
    printf("Product (fx): %lld\n", product_fx);
    printf("Result truncated (fp): %d\n", result_fx_truncated);
    printf("Result rounded (fp): %d\n", result_fx_rounded);
    printf("Result truncation (float): %.12f\n", result_fp_truncated);
    printf("Result rounding (float): %.12f\n", result_fp_rounded);

    double fp_product = (double)a * (double)b;
    printf("Product (float): %.12f\n", fp_product);
    return 0;
}