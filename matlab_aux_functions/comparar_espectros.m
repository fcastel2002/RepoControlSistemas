function comparar_espectros(varargin)
% COMPARAR_ESPECTROS Compara el espectro de magnitud de una señal base con otras.
%
%   comparar_espectros('Name', Value) grafica el espectro de frecuencia
%   de una señal base y genera una figura separada superponiéndolo con el
%   espectro de cada señal adicional para facilitar su comparación visual.
%
%   Argumentos de entrada (Pares Nombre-Valor):
%
%   'base'       - (Requerido) Vector numérico. La señal de referencia en el
%                  dominio del tiempo.
%   'compare_to' - (Opcional) Cell array de vectores numéricos. Contiene las
%                  señales que se van a comparar con la señal base.
%                  Por defecto: {} (vacío).
%   'fs'         - (Opcional) Escalar numérico. Frecuencia de muestreo en Hz.
%                  Por defecto: 1.
%   'lim_x'      - (Opcional) Escalar numérico. Límite superior del eje X
%                  (frecuencia) para la visualización. Si no se provee,
%                  se grafica el rango completo.
%   'labels'     - (Opcional) Cell array de caracteres o strings. Contiene
%                  las etiquetas para la leyenda correspondientes a las
%                  señales en 'compare_to'.
%
%   Ejemplo de uso:
%      comparar_espectros('base', señal_original, ...
%                            'compare_to', {señal_filtrada_1, señal_filtrada_2}, ...
%                            'fs', 1000, ...
%                            'lim_x', 250, ...
%                            'labels', {'Filtro A', 'Filtro B'});
%
%   Dependencias:
%      Requiere que la función my_dft(x, fs) esté en el path de MATLAB.

p = inputParser;
addParameter(p, 'base', [], @isnumeric);
addParameter(p, 'compare_to', {}, @iscell);
addParameter(p, 'fs', 1, @isnumeric);
addParameter(p, 'lim_x', [], @isnumeric);
addParameter(p, 'labels', {}, @iscell);
parse(p, varargin{:});

base_sig = p.Results.base;
comp_sigs = p.Results.compare_to;
fs = p.Results.fs;
lim_x = p.Results.lim_x;
labels = p.Results.labels;

% Validación de parámetros mínimos
if isempty(base_sig)
    error('Se debe proporcionar una señal base.');
end

% 1. Calcular espectro de la señal base
[f_base, mag_base, ~, ~, ~] = my_dft(base_sig, fs);

% 2. Calcular y graficar los espectros en figuras separadas
for i = 1:length(comp_sigs)
    [f_comp, mag_comp, ~, ~, ~] = my_dft(comp_sigs{i}, fs);

    % Determinar la etiqueta para la leyenda y el título
    if i <= length(labels)
        tag = labels{i};
    else
        tag = sprintf('Señal %d', i);
    end

    % Calcular el máximo real estrictamente para este par de señales
    max_y_actual = max([max(mag_base), max(mag_comp)]);

    figure('Position', [100 50 1000 500]);
    plot(f_base, mag_base, 'LineWidth', 2, 'DisplayName', 'Base');
    hold on;
    plot(f_comp, mag_comp, 'LineWidth', 1.5, 'DisplayName', tag);

    % Configurar el formato del gráfico
    grid on;
    if ~isempty(lim_x)
        xlim([0, lim_x]);
    end
    ylim([0, max_y_actual * 1.1]);
    xlabel('Frecuencia [Hz]');
    ylabel('|X(f)|');

    % Título dinámico
    title(['Comparacion espectro: ', tag]);

    legend('show');
    hold off;
end
end