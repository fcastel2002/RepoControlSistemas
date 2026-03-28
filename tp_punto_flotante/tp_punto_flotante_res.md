# Trabajo Práctico Punto Flotante
## Ejercicio 1
La multiplicación se redondea, y al tener que redondear dos veces, si se cambia el orden es esperable que cambie el resultado, además por el concepto de ULP (distancia entre dos float consecutivos para determinado valor)
$$a \cdot b \cdot c = 4\cdot 10^{23}$$
La ULP se define como 
$$ULP(x)\approx 2^{n-23}\ ; \ x\approx2^n$$
Si tenemos que $x=4\cdot 10^{23}$
$$\log_{2}(4\cdot 10^23)\approx 78.4 \Rightarrow n\approx 78$$
$$ULP(4\cdot10^{23})\approx2^{78-23}=2^{55}\approx 3.6 \cdot 10^{16}$$
Entonces podemos concluir que, dado que el valor sera distinto al tener que redondear dos veces, debe esperarse que entre un valor y otro existan errores del orden de $10^{16}$, en este caso los errores de $2.71\cdot10^{16} \text{ y } -8.87\cdot10^{15}$ son coherentes.

En el caso de la suma iterativa de $0.01$ 10 millones de veces, el error de la representación de este numero en binario se acumula esa cantidad de veces, lo que termina dando finalmente un error de $-1.369031e-05$

## Ejercicio 2
La funcion ``fesetround `` establece la dirección de redondeo que seguirá el compilador al redondear y ```fegetround``` devuelve la dirección actual de redondeo.

El modo de redondeo por defecto es FE_TONEAREST, es decir que redondea al mas cercano.

Si se observan diferencias claras, y son coherentes con los métodos seteados antes de cada redondeo.

## Ejercicio 4
``feclearexcept(mask)`` pone en cero los flags que se indiquen en el parametro, es decir borra el registro de las excepciones que ocurrieron, devuelve 0 si sale bien.
``feraiseeexcept(mask)`` fuerza las flags que se indiquen en mask como si hubiesen ocurrido, devuelve 0 si sale bien.
``fetestexcept(mask)`` consulta cuales de las flags que se indiquen en mask estan levantadas, devuelve un entero con bits.

## Ejercicio 6
Por consola se observa que el programa abortó la ejecución por "Floating point exception", que justamente es la funcion de ``feenableexcept`` que habilita las traps y hace que se termine la ejecución o que se dirija a la rutina de signal handler que se haya definido. 

Ahora la consola muestra la misma excepcion pero manejada, es decir que se supo a donde dirigirse una vez levantada la excepción, lo que evita comportamientos no previstos y puede llegar a contener una rutina de seguridad si el código se encarga de dirigir o controlar un sistema mecatrónico que ante una falla debe efectuar ciertas rutinas de seguridad.