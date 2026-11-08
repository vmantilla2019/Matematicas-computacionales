% FUNCION DE ANALISIS DE ERRORES DEL PROYECTO
% Muestra el error de optimizacion (gradi.m contra el optimo exacto) y las
% metricas MAE y R2 de la regresion (con los datos que guarda prueba.m).
function analisisErrores()

errorOptimizacion();
errorRegresion();

end

% ERROR DE OPTIMIZACION
% Compara el tiempo que entrega el gradiente descendente de gradi.m con el
% optimo exacto, para todos los modos y todos los rangos promedio posibles.
function errorOptimizacion()

limites = [10 20; 15 30; 20 40]; % Tiempo minimo y maximo de cada modo (los mismos de gradi.m)

disp('--- Error de optimizacion (gradiente vs optimo exacto) ---');
fprintf('%6s %10s %12s %12s %12s %12s\n', 'Modo', 'Rango prom', 'Optimo', 'Gradiente', 'Error abs', 'Error rel %');

maxAbs = 0;
maxRel = 0;
for modo = 1:3
    for promedio = 1:5
        % Optimo exacto: el tiempo objetivo que usa gradi.m
        tObjetivo = limites(modo, 1) + ((promedio - 1) / 4) * (limites(modo, 2) - limites(modo, 1));

        % Con un solo rango igual al promedio, gradi.m calcula el mismo objetivo
        tiempo = gradi(promedio, modo);

        errorAbs = abs(tiempo - tObjetivo);
        errorRel = errorAbs / tObjetivo * 100;
        maxAbs = max(maxAbs, errorAbs);
        maxRel = max(maxRel, errorRel);

        fprintf('%6d %10d %12.4f %12.4f %12.6f %12.6f\n', modo, promedio, tObjetivo, tiempo, errorAbs, errorRel);
    end
end

fprintf('Error absoluto maximo: %.6f min\n', maxAbs);
fprintf('Error relativo maximo: %.6f %%\n', maxRel);
disp('En cada iteracion la distancia al optimo se multiplica por 0.8 (1 - 2*alpha).');
disp('Despues de 50 iteraciones queda cerca del 0.0014 % de la distancia inicial.');

end

% ERROR DE REGRESION
% Calcula RMSE, MAE y R2 de los modelos de grado 1, 2 y 3 sobre los datos de
% prueba.m. Complementa el RMSE de prediccion que ya calcula models.m.
function errorRegresion()

if ~exist('resultadosMatchmaking.mat', 'file')
    disp('Primero ejecute la opcion 2 (Evaluacion del matchmaking) para generar los datos de la regresion.');
    return;
end

datos = load('resultadosMatchmaking.mat'); % Contiene poblaciones y porcentaje
x = datos.poblaciones / 1000;              % Se divide entre 1000 para evitar numeros grandes en el ajuste
y = datos.porcentaje / 100;
pruebas = 30;                              % Repeticiones por poblacion que usa prueba.m

disp(' ');
disp('--- Error de regresion (con todos los datos de prueba.m) ---');
fprintf('%8s %10s %10s %10s\n', 'Grado', 'RMSE', 'MAE', 'R2');
for grado = 1:3
    coef = polyfit(x, y, grado);
    yAjuste = polyval(coef, x);
    [rmse, mae, r2] = metricasError(y, yAjuste);
    fprintf('%8d %10.4f %10.4f %10.4f\n', grado, rmse, mae, r2);
end

% Fuente del error: cada tasa sale de pocas pruebas, asi que tiene ruido
ruido = sqrt(mean(y .* (1 - y) / pruebas));
fprintf('\nRuido de la simulacion (con %d pruebas): %.4f\n', pruebas, ruido);
disp('Ese ruido es parte del error y ningun modelo lo puede quitar.');
disp('Ademas, la tasa de exito tiene forma de S y un polinomio solo la aproxima.');
disp('Nota: estas metricas usan los mismos datos del ajuste, por eso el grado 3 casi siempre sale mejor.');

end

% METRICAS DE ERROR
% Recibe los valores reales y los ajustados. Devuelve RMSE, MAE y R2.
function [rmse, mae, r2] = metricasError(yReal, yAjuste)

rmse = RMSE(yReal, yAjuste); % Funcion RMSE.m del proyecto
mae = mean(abs(yReal - yAjuste));

sst = sum((yReal - mean(yReal)) .^ 2);
if sst == 0
    r2 = NaN; % Si todos los valores son iguales, R2 no esta definido
else
    r2 = 1 - sum((yReal - yAjuste) .^ 2) / sst;
end

end
