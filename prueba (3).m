
clc;
clear;
close all;

% Configuracion del experimento
poblaciones = [500,800, 1000, 1500, 2000];
pruebas = 30;

% Elegir condiciones fijas para comparar poblaciones
MiRegion = input("Elige tu region (1-5): ");
MiModo = input("Elige tu modo (1-3): ");
MiRango = input("Elige tu rango (1-5): ");

% Cantidad total de jugadores por partida
if MiModo == 1
    cantidadNecesaria = 4;
elseif MiModo == 2
    cantidadNecesaria = 10;
elseif MiModo == 3
    cantidadNecesaria = 25;
else
    error("Modo de juego invalido.");
end

% Guardar resultados
exitos = zeros(1, length(poblaciones));

for p = 1:length(poblaciones)

    n = poblaciones(p);

    for t = 1:pruebas


        % Generar poblacion
        JRango = randi([1 5], [1 n]);
        JRegion = randi([1 5], [1 n]);
        JModo = randi([1 3], [1 n]);

        % Reservar el jugador 1 para el usuario
        JRango(1) = MiRango;
        JRegion(1) = MiRegion;
        JModo(1) = MiModo;

        % Filtrar candidatos
        CompatiblesRango = abs(JRango - MiRango) <= 1;
        CompatiblesRegion = JRegion == MiRegion;
        CompatiblesModo = JModo == MiModo;

        JugadoresCompatibles = CompatiblesRango & CompatiblesRegion & CompatiblesModo;

        JugadoresCompatibles(1) = false;

        IndicesCompatibles = find(JugadoresCompatibles);

        % Grupos que no mezclan rangos incompatibles
        GrupoInferior = IndicesCompatibles( JRango(IndicesCompatibles) == MiRango | JRango(IndicesCompatibles) == MiRango - 1);

        GrupoSuperior = IndicesCompatibles(JRango(IndicesCompatibles) == MiRango | JRango(IndicesCompatibles) == MiRango + 1);

        necesarios = cantidadNecesaria - 1;

        % Contar exito si algun grupo completa la partida
        if length(GrupoInferior) >= necesarios || length(GrupoSuperior) >= necesarios

            exitos(p) = exitos(p) + 1;
        end
    end
end


% Mostrar tabla de resultados
porcentaje = exitos / pruebas * 100;

Resultados = table(poblaciones', exitos', porcentaje', ...
    'VariableNames', {'Poblacion', 'PartidasCompletadas', ...
    'PorcentajeExito'});

disp("=== RESULTADOS DEL EXPERIMENTO ===");
disp(Resultados);


% Grafica de resultados
x = poblaciones;
y = porcentaje / 100;

figure;
plot(x, y, '*');
hold on;

% Regresion cuadratica
c = polyfit(x, y, 1);
c1 = polyfit(x, y, 2);
c2 = polyfit(x, y, 3);

x_test = 500:10:2000;
y_fit = polyval(c, x_test);
y_fit1 = polyval(c1, x_test);
y_fit2 = polyval(c2, x_test);


% Calcular RMSE de cada modelo
error_lineal = 1/sqrt(length(y))*norm(y - polyval(c, x));

error_cuadratico = 1/sqrt(length(y))*norm(y - polyval(c1, x));

error_cubico = 1/sqrt(length(y))*norm(y - polyval(c2, x));
hold on;
% Mostrar resultados

plot(x_test, y_fit, 'b-', ...
    'DisplayName', ['Lineal: ' num2str(error_lineal)]);

plot(x_test, y_fit1, 'r-', ...
    'DisplayName', ['Cuadratico: ' num2str(error_cuadratico)]);

plot(x_test, y_fit2, 'g-', ...
    'DisplayName', ['Cubico: ' num2str(error_cubico)]);
hold on;
legend show;

xlabel('Poblacion');
ylabel('Tasa de exito');
title('Poblacion vs. tasa de exito');

legend show;


grid on;
grid on;
axis([500 2200 0 1.1]);

hold off;

