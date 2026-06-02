
%% PARCIAL II: CONTROL Y SISTEMAS
% NOMBRE: FRANCISCO CASTEL
% LEGAJO: 13784
%% Criterio de evaluaión
% _"Se evaluará la calidad del razonamiento 
% técnico y la justificación de las decisiones de diseño."_
%
% _"Priorizar en el análisis descripciones cuantitativas y objetivas." 
% 
% _"Cuide la presentación, escala, colores, títulos y leyendas de sus gráficos para hacerlos 
% lo más legible posible para la evaluación."_

clear;
clc;
close all;

%% Contexto
% Tenemos un sistema que deberá ser modelado, controlado y analizado. Se trata de un
% portón corredizo movido por un motor con su eje solidario a un mecanismo 
% de piñon y cremallera solidaria al portón que permite que este se
% desplace linealmente al girar el motor. La forma en la que el sistema
% disipa la energía se encuentra experimentalmente. 


%% Objetivo
% Modelar y analizar el sistema. 
clc
close all 

m = 200; %kg
c = 0; % Ns/m estimar c
magnitud_pulso_perturbacion = 100; % N
tiempo_pulso_perturbacion = 49; % s
R = 0.05; % m radio del piñón
tau_maximo_motor = 200; % Nm




%% 1. Modelado del Portón Corredizo
% Modele el portón corredizo. Estimar  el parámetro faltante (c) sabiendo que el portón pasa
% sin fuerzas externas (ni perturbación ni motor) de 1m/s a 0.1m/s en 1s. 
% Luego de obtener las ecuaciones físicas elabore un modelo en SIMULINK.
% Valide el modelo.


% [Ingresa tu modelado aquí]
% a(t) = x_ddot(t), v(t) = x_dot(t), m, c
% m x_ddot(t) + c x_dot(t) = F(t)
% donde F(t) incluye perturbacion y motor
% En espacio de estados definimos entonces
% x1 = x(t); x2 = x_dot(t)
% Nos quedan las ecuaciones
% x1_dot = x2
% x2_dot = (F(t) - c x2)/m = 1/m F(t) - c/m x2
% Para calcular c se hace F(t) = 0 por lo tanto
% x2_dot = -c/m x2
% Donde tenemos una ecuacion lineal homogenea donde la solucion es
% x2(t) = x2(0)e(-c/m *t)
% Sabemos que x2(0) = 1 asi que reemplazando t=1 y x2(t=1)==0.1 despejamos
% c
c = -log(0.1)*200;

% c = 460.517 [Ns/m]

% Se aceptan aproximaciones de c por prueba y error, si cumplen con        
% v(0 s) = 1.0 m/s    ^    v(1 s) = 0.1 m/s
% con un error menor al 5% en términos de velocidad.


%% 2. Integración con el Controlador de velocidad
% Integre su modelo al controlador PID dado y luego analice desempeño
% frente a r(t) como escalón de 1 m/s

% [SIMULINK]
% El desempeño frente al escalon de velocidad de 1 m/s es el siguiente:
% Settling time: Aproxidamente a los 30 segundos el sistema ya se encuentra
% en la referencia.
% Overshoot: no se puede apreciar overshoot

%% 3. Análisis de Perturbaciones
% Modela el ingreso de una perturbación externa tipo pulso de fuerza de 100 N que va en sentido 
% contrario al de la apertura, justo en el instante de transcurridos
% 49 s de iniciada la maniobra. 
%
% Evalúa el rechazo a esta perturbación de forma objetiva proponga una métrica.

% [Ingresa tu análisis de perturbaciones aquí]
% Se pueden plantear las mismas metricas que para la referencia, en este
% caso una métrica útil seria la diferencia maxima de velocidad que genera ese torque contrario,
% para evaluar cuanto se frena el motor frente a perturbaciones, ya que
% evaluar cuanto se demora en volver a la referencia, no seria util en el caso 
% de frenarse no me importa cuanto demora en volver a 1 m/s.
% En este caso el delta v max, es 0.04 m/s, por lo que se desvió solamente
% un 4% de la referencia. (la métrica se evaluó de forma aproximada
% mediante el gráfico en el data inspector)


%% 4. Rediseño del Controlador (Sintonía)
% Modifica la sintonía del control cumpliendo con los siguientes compromisos:
% 1. Hacer que el portón abra más rápido ante un escalón en la referencia de velocidad.
% 2. Que la respuesta ante la perturbación se mantenga idéntica a la del punto anterior.

% Copia y pega los bloques del sistema completo, de manera de ver el modelo
% antes y después de rediseñar el controlador, con idénticas r(t) y d(t).

% [SIMULINK]
% Se realizó una modificación a la arquitectura del controlador, ya que se
% añadió un término feedforward Kff * r.
% Mediante prueba y error, se encontro un valor de Kff=2400, con el cual se
% logra un settling time de aproximadamente 2 segundos, una mejora de
% aproximadamente.
mejora = (30-2)/30 * 100;
%  93.3%, o tambien 30/2 = 15, se llega a la referencia 15 veces más
%  rápido.
%% 5. Análisis del Actuador
% A partir de la nueva acción de control (torque del motor con el controlador rediseñado), 
% determina si esto requiere el reemplazo del motor por uno de mayor capacidad.

% [Ingresa tu análisis del actuador aquí]
% Aún con un término de feedforward, y una mejora del 93.3% en rapidéz, el
% torque máximo del motor (200 N.m) alcanza para cumplir con el desempeño
% obtenido en simulación, ya que solo necesita (120 N.m), es decir, usando 
% un 60% de la capacidad maxima de torque. Al noespecificarse margenes de
% seguridad ni un criterio de seguridad específico, podemos decir que no es
%  necesario cambiar el motor por uno de mayor capacidad.