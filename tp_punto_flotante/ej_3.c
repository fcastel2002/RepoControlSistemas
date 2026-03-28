#include <math.h>
#include <stdio.h>


int main(void)
{
    float notANumber = 0.0f / 0.0f;
    float infinity = 1.0f / 0.0f;
    float negativeInfinity = -1.0f / 0.0f;

    printf("Not a Number: %f\n", notANumber);
    printf("Infinity: %f\n", infinity);
    printf("Negative Infinity: %f\n", negativeInfinity);

    return 0;
}