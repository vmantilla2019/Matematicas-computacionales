% EVALUACION EXPERIMENTAL DEL MODELO DE MATCHMAKING
% Compara la capacidad de encontrar jugadores compatibles para diferentes
% tamanos de poblacion, realizando varias simulaciones por cada tamaño

clc; 

% Define los tamanos de poblacion que se van a evaluar y el numero de repeticiones
poblaciones = [500,800, 1000, 1500, 2000];
pruebas = 30;

% Solicita las condiciones del jugador que se mantendran fijas durante el experimento
MiRegion = input("Elige tu region (1-5): ");
MiModo = input("Elige tu modo (1-3): ");
MiRango = input("Elige tu rango (1-5): ");

% Determina la cantidad total de participantes que requiere cada modo de juego
if MiModo == 1
    cantidadNecesaria = 4;
elseif MiModo == 2
    cantidadNecesaria = 10;
elseif MiModo == 3
    cantidadNecesaria = 25;
else
    error("Modo de juego invalido.");
end

% Inicializa el contador de partidas exitosas para cada tamano de poblacion
exitos = zeros(1, length(poblaciones));

% Recorre cada uno de los tamanos de poblacion definidos
for p = 1:length(poblaciones)

    n = poblaciones(p); % Obtiene el tamano de la poblacion que se evaluara

    % Repite la simulacion el numero de veces establecido para cada poblacion
    for t = 1:pruebas

        % Genera aleatoriamente los rangos, regiones y modos de todos los jugadores
        JRango = randi([1 5], [1 n]);
        JRegion = randi([1 5], [1 n]);
        JModo = randi([1 3], [1 n]);

        % Asigna al primer jugador las caracteristicas fijas indicadas por el usuario
        JRango(1) = MiRango;
        JRegion(1) = MiRegion;
        JModo(1) = MiModo;

        % Evalua por separado las restricciones de rango, region y modo de juego
        CompatiblesRango = abs(JRango - MiRango) <= 1;
        CompatiblesRegion = JRegion == MiRegion;
        CompatiblesModo = JModo == MiModo;

        % Identifica los jugadores que cumplen simultaneamente las tres restricciones
        JugadoresCompatibles = CompatiblesRango & CompatiblesRegion & CompatiblesModo;

        JugadoresCompatibles(1) = false; % Excluye al jugador principal de los candidatos

        IndicesCompatibles = find(JugadoresCompatibles); % Guarda las posiciones de los candidatos compatibles

        % Divide los candidatos en dos grupos posibles para evitar combinar rangos
        % de ambos lados del rango del usuario en una misma partida
        GrupoInferior = IndicesCompatibles( JRango(IndicesCompatibles) == MiRango | JRango(IndicesCompatibles) == MiRango - 1);

        GrupoSuperior = IndicesCompatibles(JRango(IndicesCompatibles) == MiRango | JRango(IndicesCompatibles) == MiRango + 1);

        necesarios = cantidadNecesaria - 1; % Calcula los participantes adicionales requeridos

        % Registra un exito si al menos uno de los dos grupos puede completar la partida
        if length(GrupoInferior) >= necesarios || length(GrupoSuperior) >= necesarios

            exitos(p) = exitos(p) + 1; % Incrementa el contador de exitos para la poblacion actual
        end
    end
end

% Calcula el porcentaje de exito obtenido en las repeticiones de cada poblacion
porcentaje = exitos / pruebas * 100;
% Guarda los tamanos de poblacion y sus porcentajes para utilizarlos en el analisis de regresion
save('resultadosMatchmaking.mat', 'poblaciones', 'porcentaje');

% Construye una tabla
Resultados = table(poblaciones', exitos', porcentaje','VariableNames', {'Poblacion', 'PartidasCompletadas','PorcentajeExito'});

disp("=== RESULTADOS DEL EXPERIMENTO ===");
disp(Resultados); 

% Prepara los datos para la grafica: poblacion en x y tasa de exito entre 0 y 1 en y
x = poblaciones;
y = porcentaje / 100;

% Grafica los resultados experimentales como puntos
figure;
plot(x, y, '*');
hold on;

% Ajusta polinomios de grado 1, 2 y 3 a los datos
c = polyfit(x, y, 1); % Regresion lineal
c1 = polyfit(x, y, 2); % Regresion cuadratica
c2 = polyfit(x, y, 3); % Regresion cubica

% Genera valores de poblacion para dibujar las curvas de regresion
x_test = 500:10:2000;
y_fit = polyval(c, x_test); % Valores estimados por el modelo lineal
y_fit1 = polyval(c1, x_test); % Valores estimados por el modelo cuadratico
y_fit2 = polyval(c2, x_test); % Valores estimados por el modelo cubico

% Calcula el RMSE de cada ajuste usando los puntos experimentales disponibles
error_lineal = 1/sqrt(length(y))*norm(y - polyval(c, x));

error_cuadratico = 1/sqrt(length(y))*norm(y - polyval(c1, x));

error_cubico = 1/sqrt(length(y))*norm(y - polyval(c2, x));
hold on;

% Dibuja las tres curvas e incluye el error
plot(x_test, y_fit, 'b-','DisplayName', ['Lineal: ' num2str(error_lineal)]);

plot(x_test, y_fit1, 'r-', 'DisplayName', ['Cuadratico: ' num2str(error_cuadratico)]);

plot(x_test, y_fit2, 'g-','DisplayName', ['Cubico: ' num2str(error_cubico)]);
hold on;
legend show;

% Agrega nombres a los ejes y titulo de la grafica
xlabel('Poblacion');
ylabel('Tasa de exito');
title('Poblacion vs. tasa de exito');

legend show; 

grid on; 
grid on;
axis([500 2200 0 1.1]); % Establece los limites visibles de los ejes

hold off; 