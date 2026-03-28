#include <fenv.h>
#include <float.h>
#include <math.h>
#include <stdio.h>

#pragma STDC FENV_ACCESS ON

static void print_flags(int flags)
{
	if (flags == 0) {
		printf("  excepciones: none\n");
		return;
	}

	printf("  excepciones:");
	if (flags & FE_INVALID) {
		printf(" FE_INVALID");
	}
	if (flags & FE_DIVBYZERO) {
		printf(" FE_DIVBYZERO");
	}
	if (flags & FE_OVERFLOW) {
		printf(" FE_OVERFLOW");
	}
	if (flags & FE_UNDERFLOW) {
		printf(" FE_UNDERFLOW");
	}
	if (flags & FE_INEXACT) {
		printf(" FE_INEXACT");
	}
	printf("\n");
}

int main(void)
{
	volatile double a;
	volatile double b;
	int flags;

	/* 1) FE_INVALID: operacion invalida */
	feclearexcept(FE_ALL_EXCEPT);
	a = 0.0;
	b = a / a; /* 0.0 / 0.0 */
	(void)b;
	flags = fetestexcept(FE_ALL_EXCEPT);
	printf("Caso FE_INVALID (0.0/0.0):\n");
	print_flags(flags);

	/* 2) FE_DIVBYZERO: division por cero con numerador no cero */
	feclearexcept(FE_ALL_EXCEPT);
	a = 1.0;
	b = a / 0.0;
	(void)b;
	flags = fetestexcept(FE_ALL_EXCEPT);
	printf("Caso FE_DIVBYZERO (1.0/0.0):\n");
	print_flags(flags);

	/* 3) FE_OVERFLOW: resultado demasiado grande */
	feclearexcept(FE_ALL_EXCEPT);
	a = DBL_MAX;
	b = a * 2.0;
	(void)b;
	flags = fetestexcept(FE_ALL_EXCEPT);
	printf("Caso FE_OVERFLOW (DBL_MAX*2.0):\n");
	print_flags(flags);

	/* 4) FE_UNDERFLOW: resultado demasiado pequeno */
	feclearexcept(FE_ALL_EXCEPT);
	a = DBL_MIN;
	b = a * a;
	(void)b;
	flags = fetestexcept(FE_ALL_EXCEPT);
	printf("Caso FE_UNDERFLOW (DBL_MIN*DBL_MIN):\n");
	print_flags(flags);

	/* 5) FE_INEXACT: resultado no representable exactamente */
	feclearexcept(FE_ALL_EXCEPT);
	a = 2.0;
	b = a / 3.0;
	(void)b;
	flags = fetestexcept(FE_ALL_EXCEPT);
	printf("Caso FE_INEXACT (2.0/3.0):\n");
	print_flags(flags);

	return 0;
}
