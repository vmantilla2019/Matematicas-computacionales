% FUNCION DE ANALISIS DE COMPLEJIDAD COMPUTACIONAL
% Mide el tiempo del filtrado y la seleccion de jugadores para distintos
% tamanos de poblacion y estima el orden de crecimiento.
function analisisComplejidad()

tamanos = [1e4 5e4 1e5 5e5 1e6];
tiempos = zeros(1, length(tamanos));

for i = 1:length(tamanos)
    n = tamanos(i);

    % Genera la poblacion igual que modelo.m (rango 1-5, region 1-5, modo 1-3)
    JRango = randi([1 5], [1 n]);
    JRegion = randi([1 5], [1 n]);
    JModo = randi([1 3], [1 n]);

    % Se repite 5 veces y se promedia para que la medida sea estable
    suma = 0;
    for rep = 1:5
        tic;
        compatibles = abs(JRango - 3) <= 1 & JRegion == 1 & JModo == 1;
        compatibles(1) = false;
        indices = find(compatibles);
        seleccionarJugadores(JRango, indices, 3, 3);
        suma = suma + toc;
    end
    tiempos(i) = suma / 5;
end

disp('--- Complejidad computacional ---');
fprintf('%10s %14s\n', 'n', 'tiempo (s)');
for i = 1:length(tamanos)
    fprintf('%10d %14.6f\n', tamanos(i), tiempos(i));
end

% La pendiente en escala log-log indica el exponente: tiempo ~ n^pendiente
ajuste = polyfit(log(tamanos), log(tiempos), 1);
fprintf('Pendiente log-log: %.2f (cerca de 1 significa crecimiento lineal)\n', ajuste(1));

disp(' ');
disp('Analisis teorico (n = numero de jugadores):');
disp('Filtrar jugadores:             tiempo O(n), espacio O(n)');
disp('Seleccionar jugadores:         tiempo O(n), espacio O(n)');
disp('Descenso del gradiente:        tiempo O(K), K = iteraciones');
disp('Regresion polinomial:          tiempo O(N), N = puntos (el grado es fijo)');
disp('Evaluacion del matchmaking:    O(P*T*n), es el cuello de botella (prueba.m)');
disp('Como hay que revisar a todos los jugadores, el filtrado es Theta(n).');

figure;
loglog(tamanos, tiempos, 'b*-');
xlabel('Poblacion n');
ylabel('Tiempo (s)');
title('Tiempo del matchmaking vs. poblacion');
grid on;

end
