%% CASTEL, FRANCISCO: 13784


%% PARCIAL I: CONTROL Y SISTEMAS


%% Contexto
% Estás analizando la cantidad de turnos atendidos en un consultorio médico. 
% El sistema registra diariamente el número de pacientes atendidos, generando 
% una serie temporal discreta x[k], donde cada muestra representa un día.

%% Objetivo
% El equipo de gestión solicita elaborar un reporte resumido con un *valor representativo 
% cada 10 días*, con el objetivo de facilitar el monitoreo operativo y la planificación 
% de recursos a largo plazo, eliminando las fluctuaciones diarias irrelevantes 
% para la tendencia general anual.

%% Criterio de evaluaión
% _“No se evaluará únicamente el resultado numérico, sino la calidad del razonamiento 
% técnico y la justificación de las decisiones de diseño.”_
%
% _"Cuide la presentación, escala, colores, títulos y leyendas de sus gráficos para hacerlos 
% lo más legible posible para la evaluación."_

%% Tareas a desarrollar
% Diseñar e implementar en MATLAB un script que permita reducir la serie 
% temporal original. La salida debe ser una nueva serie reducida que entregue 
% un valor representativo cada 10 días.


%% 1. Análisis Previo de los Datos
% Seleccione y aplique comandos de MATLAB para estudiar la señal original 
% y extraer la información relevante.


%% 
%------
clc 
clear
x = load('datos_turnos.txt');
%------
N = length(x)
std_x = std(x)
dx_x = diff(x);
max_dx = max(dx_x)
min_dx = min(dx_x)
espectro_x = abs(fft(x)) / N;
fs =1;
f_axis = linspace(0, fs/2, floor(N/2));
figure
plot(f_axis, espectro_x(1:floor(N/2)), 'linewidth', 2);
xlabel('Frecuencia (ciclos/día)')
ylabel('Magnitud |X(f)|')
title('Espectro de Frecuencias de los Turnos Diarios')
grid on
%%
% 
% *1.1 Justifique brevemente la elección de dichas herramientas*

% Respuesta
% El tamaño de la muestra para luego tenerla en cuenta para implementar "cada 10 dias",
% la desviacion estándar para las desviaciones diarias irrelevantes, y los
% maximos y minimos de la tasa de cambio para el ejercicio 5 que le da
% importancia a que tan rapido sube o baja la cantidad de pacientes. Por
% ultimo el espectro para una eleccion correcta del filtrado.
% Por ultimo se puede ver que puede considerarse a f=1/7 se cumple un
% ciclo semanal, poca demanda los domingos por no decir 0, y alta demanda los
% lunes.
% 
%%
% 
% *1.2 Explique los resultados obtenidos del análisis*

% Respuesta
% Se estan tomando en cuenta 5 años de muestras ya que 1825/365=5.
% Aproximadamente hay una fluctuacion practica de 3 pacientes sobre la media
% general dado que la std de x dió 2.588.
% La demanda de pacientes nunca cae mas de 2 o sube mas de 2 de un día para
% el otro.

%%
% 
% *1.3 Mencione qué información le resulta relevante y útil para la solución.*
% La desviación estandar para comparar la señal luego de aplicarle el
% filtro, y la tasa de cambio para la representacion en punto fijo. Por
% ultimo el espectro mostrando el comportamiento de indole semanal me da
% información de donde filtrar.
% Respuesta

%% 2. Pre-Proceso
% *Proceda a realizar el tratamiento de la señal*


%% 
%-----------------------------------------
% Coloque el código de su solución aquí
%-----------------------------------------
M = 7;
b = ones(1,M)/M;
a = 1;
filtered_x = filter(b,a,x);
% figure
% subplot(3,1,1)
% plot(x)
% subplot(3,1,2)
% plot(filtered_x)
% Primero filtramos despues decimamos
subsampled_filtered_x = filtered_x(1:10:end);
subplot(3,1,3)
plot(subsampled_filtered_x)
%-----------------------------------------


%%
% 
% *2.1 Comente brevemente sobre el método elegido para el pre-procesamiento.*

% Respuesta
% Se uso un filtro de media movil con ventana M=7 correspondiente a 1
% semana.
%%
% 
% *2.2 ¿Por qué dicha técnica es necesaria y adecuada para este problema específico? (considerando el contenido frecuencial).*

% Respuesta
% Es necesaria para eliminar el ruido montado sobre la media general de la
% este "ruido" es de frecuencia 1/7 por lo tanto con un filtro de media
% movil con la misma ventana que el periodo, se consigue cancelar esa
% frecuencia.
%%
% 
% *2.3 Mencione los criterios utilizados para definir los parámetros del sistema de procesamiento.*

% Respuesta
% Ya que en una ventana de M=7 entra un ciclo completo, promediando así 0 y
% cancelandose dicha frecuencia.

%% 3. Generar serie final y gráficos
% A partir del procesamiento anterior, generar la serie final y grafiquela en 
% el tiempo y la frecuencia. Asegurarse de que la alineación temporal sea correcta 
% respecto a la señal original.
%

%% 
%-----------------------------------------
% Coloque el código de su solución aquí
%-----------------------------------------
t_x = 1:length(x);
t_sub = 1:10:length(x);
subplot(2,1,1);
plot(t_x, x,'linewidth', 1)
hold on;
plot(t_sub, subsampled_filtered_x,'linewidth', 1)
legend('x','filtered\_x subsampled')
hold off;
N1 = length(x);
N2 = length(subsampled_filtered_x);
fs1 = 1;
fs2 = fs1/10;
X1 = abs(fft(x))/N1;
X2 = abs(fft(subsampled_filtered_x))/N2;
f1 = linspace(0, fs1/2, floor(N1/2));
f2 = linspace(0, fs2/2, floor(N2/2));
subplot(2,1,2);
plot(f1, X1(1:floor(N1/2)),'linewidth', 1)
hold on;
plot(f2, X2(1:floor(N2/2)),'linewidth', 1)
legend('X(f)','Filtered & subsampled X(f)')
hold off;
%-----------------------------------------




%% 4. Validación de la respuesta
% Comparar su solución con al menos una alternativa que considere incorrecta 
% o subóptima para validar por contraste la suya. 


%% 
%-----------------------------------------
% Coloque el código de su solución aquí
%-----------------------------------------
% La alternativa mas intuitiva si se puede decir es la de realizar un
% promedio de los ultimos 10 dias.
M_alter = 10;
b_alter = ones(1,M_alter)/M_alter;
a = 1;
filtered_x_alter = filter(b_alter,a,x);
subsampled_alter = filtered_x_alter(1:10:end);
t_x = 1:length(x);
t_sub = 1:10:length(x);

figure;
subplot(2,1,1);
plot(t_x, x,'linewidth',1)
hold on;
plot(t_sub, subsampled_filtered_x,'linewidth',1)
plot(t_sub, subsampled_alter,'linewidth',1)
legend('x','filtered\_x subsampled','alt subsampled')
hold off;

N3 = length(subsampled_alter);
fs3 = fs1/10;

X3 = abs(fft(subsampled_alter))/N3;
f3 = linspace(0, fs3/2, floor(N3/2));

subplot(2,1,2);
plot(f1, X1(1:floor(N1/2)),'linewidth',1)
hold on;
plot(f2, X2(1:floor(N2/2)),'linewidth',1)
plot(f3, X3(1:floor(N3/2)),'linewidth',1)
legend('X(f)','Filtered & subsampled','Alt filtered & subsampled')
hold off;
m1_opt = std(diff(subsampled_filtered_x));
m1_alt = std(diff(subsampled_alter));
m2_opt = max(abs(diff(subsampled_filtered_x)));
m2_alt = max(abs(diff(subsampled_alter)));
m1_orig = std(diff(x));
fprintf('std(diff) -> Original: %.4f | Optima: %.4f | Alter: %.4f\n', m1_orig, m1_opt, m1_alt);
fprintf('max(abs(diff)) -> Optima: %.4f | Alter: %.4f\n', m2_opt, m2_alt);
%-----------------------------------------


%%
% 
% *4.1 Qué efectos negativos produce la alternativa subóptima (en el dominio del tiempo y/o frecuencia).*

% Respuesta
% Se produce aliasing, las fluctuaciones se superponen en las freq bajas.
%%
% 
% *4.2 Por qué su solución propuesta mitiga estos efectos.*

% Respuesta
% promedia y suaviaza los datos diarios reduciendo los picos maximos,
% atenua perfectamente el ruido semanal de alta frecuencia permitiendo un
% submuestreo sin aliasing.
%% 5. Tasa de Cambio (Derivada) y Punto Fijo
% Se nos comunica que conocer solo la cantidad total de pacientes ya no es suficiente para organizar el consultorio. 
% Ahora necesitamos saber qué tan rápido sube o baja esa cantidad. Esta 
% "velocidad de cambio" de la demanda se calcula directamente usando la derivada matemática.
%%
% Como ingeniero proponés usar *representación en punto fijo* para optimizar el sistema: 
% buscamos aumentar la velocidad de cálculo y minimizar el uso de memoria.

%%
% 
% # Construya la velocidad de cambio de *su señal resultado del ejercicio anterior* en (turno/día). 
% # Analice cómo se distribuyen los valores de su señal (usando un histograma o gráfico). 
% # A partir de esa observación, determine un formato en punto fijo conveniente que ajuste para dicho rango 
% # Indique de su respuesta: N tamaño de la palabra binaria (8,16 o 32 bits) y los m bits para la parte entera, n bits para la parte fraccionaria usando la notación Qm.n (con 1 bit de signo), rango, resolución y ruido cuantización 




%%
% *Completar con los resultados obtenidos:*

%%
% * *Palabra binaria:* 8
% * *Representación*:Q1.6
% * *Rango*: -2 a 1.984375  
% * *Resolución:*: 0.015625
% * *Ruido de cuantización*:0.0000203451


%% 
%-----------------------------------------
% Cálculo de la velocidad 
%-----------------------------------------
Ts = 10;
v = diff(subsampled_filtered_x)/Ts;

figure;
histogram(v);
xlabel('Tasa de cambio [turno/día]');
ylabel('Cantidad de muestras');
title('Distribución de la tasa de cambio');
grid on;

%-----------------------------------------
% Coloque el código de su solución aquí
%-----------------------------------------
v_max = max(v);
v_min = min(v);
v_abs_max = max(abs(v));

N = 8;
m = ceil(log2(v_abs_max + 1));
n = N - 1 - m;

rango_min = -2^m;
rango_max = 2^m - 2^(-n);
resolucion = 2^(-n);
ruido_cuantizacion = resolucion^2/12;

v_fixed = round(v/resolucion)*resolucion;

fprintf('Valor mínimo de la derivada: %.6f turno/día\n', v_min);
fprintf('Valor máximo de la derivada: %.6f turno/día\n', v_max);
fprintf('Formato elegido: Q%d.%d\n', m, n);
fprintf('N = %d bits\n', N);
fprintf('m = %d bits parte entera\n', m);
fprintf('n = %d bits parte fraccionaria\n', n);
fprintf('Rango: [%.6f , %.6f]\n', rango_min, rango_max);
fprintf('Resolución: %.6f\n', resolucion);
fprintf('Ruido de cuantización: %.10f\n', ruido_cuantizacion);

%-----------------------------------------







