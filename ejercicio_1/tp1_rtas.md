# Trabajo Practico Punto Fijo

## Ejercicio 1
 1. No, los valores no son correctos.
    Se obtienen los valores:
    c=-2; d=1.
 2. La solución mas clara y directa es declarar a las variables c y d como `int16_t`, o `signed short`.Ya que evitaría el overflow producido en ambas operaciones. Aunque una forma mas general (en terminos de CPU) seria usar el tipo `int_least16_t` que le dice al compilador que use menor tipo disponible que al menos tenga 16 bits (evidentemente se estan obviando las soluciones de asignar espacio de 32 y 64 bits).
 3. Si, los valores son correctos
    1. En s1 se esta dividiendo -8 por 4, lo que si realizamos la operacion en binario:
   `8 = 0000 1000`. Luego para obtener -8 invertimos y sumamos 1.
   `-8 = 1111 0111 + 0000 0001 = 1111 1000`. Por lo tanto `(-8) >> 2 = 1111 1110` Donde si invierto y sumo 1 me da 2. Por lo tanto el valor de s1 es correcto.
      1. En s2 es analogo, ya que `-1 = 1111 1111` y desplazar bits a la derecha resultaria nuevamente en `1111 1111`, por lo que el resultado de `-1` es correcto.

## Ejercicio 2

   