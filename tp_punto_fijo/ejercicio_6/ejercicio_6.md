Para garantizar que no haya overflow debemos aclarar el peor caso de las sumas que se realizaran, siendo que el mayor numero entero con signo en un DSP de 16 bits será.

num_max = $2^{15}-1$

Donde el numero maximo que podra contener la ALU es 

num_max_ALU = $2^{39}-1$

Por lo tanto se debe buscar N (cantidad de sumas) tal que

$N * (2^{15}-1) <= 2^{39}-1$

$N <= \frac{2^{39}-1}{2^{15}-1}$

Que puede aproximarse rapidamente a $2^{39-15}=2^{24}=16777216$

Podriamos por lo tanto tomar como regla rapida:

bits_acumulador_alu - bits_dsp(operaciones) = N_sumas_max