
function tiempo = gradi(rangos, modo)

% Tiempos segun el modo de juego
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
    error('Modo invalido');
end

% Promedio de los rangos
promedio = mean(rangos);

% Duracion objetivo segun el rango promedio
tiempoObjetivo = tiempoMin + ...
    ((promedio - 1) / 4) * (tiempoMax - tiempoMin);

% Gradiente descendente
t = tiempoMax;
alpha = 0.1;

for i = 1:50
    gradiente = 2 * (t - tiempoObjetivo);
    t = t - alpha * gradiente;
end

tiempo = t;

end
