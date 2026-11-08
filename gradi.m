% FUNCION PARA ESTIMAR LA DURACION DE UNA PARTIDA CON GRADIENTE DESCENDENTE
% Recibe los rangos de los participantes y el modo de juego. Devuelve
% una estimacion del tiempo de partida en minutos.
function tiempo = gradi(rangos, modo)

% Define los tiempos minimo y maximo permitidos para cada modo de juego.
if modo == 1
    tiempoMin = 10;
    tiempoMax = 20;
elseif modo == 2
    tiempoMin = 15;
    tiempoMax = 30;
elseif modo == 3
    tiempoMin = 20;
    tiempoMax = 40;
else
    error('Modo invalido'); % Detiene la funcion si el modo no corresponde a las opciones disponibles.
end

% Calcula el promedio de los rangos recibidos como entrada.
promedio = mean(rangos);

% Convierte el rango promedio en un tiempo objetivo dentro del intervalo
% definido para el modo de juego seleccionado.
tiempoObjetivo = tiempoMin + ((promedio - 1) / 4) * (tiempoMax - tiempoMin);

% Inicializa el proceso de gradiente descendente desde el tiempo maximo
t = tiempoMax;
alpha = 0.1; % Define la tasa de aprendizaje o tamano del paso de actualizacion

% Realiza 50 iteraciones para acercar t al tiempo objetivo.
for i = 1:50
    gradiente = 2 * (t - tiempoObjetivo); % Derivada de la funcion de error cuadratico respecto a t
    t = t - alpha * gradiente; % Actualiza t en direccion opuesta al gradiente.
end

% Entrega el valor final como estimacion de la duracion de la partida
tiempo = t;

end
