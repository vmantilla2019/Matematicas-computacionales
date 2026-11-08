% PROGRAMA PRINCIPAL DEL ANALISIS DE REGRESION
% Carga los resultados del experimento, separa los datos de entrenamiento
% y prueba, y solicita el calculo de los errores de los modelos polinomicos.

clc; 

% Carga las variables poblaciones y porcentaje guardadas por prueba.m.
load('resultadosMatchmaking.mat');

% Define la poblacion como variable independiente y la tasa de exito
% como variable dependiente
x = poblaciones;
y = porcentaje / 100;

% Utiliza los primeros cuatro datos para construir los modelos de regresion.
x_train = x(1:4);
y_train = y(1:4);

% Reserva el ultimo dato para evaluar las predicciones de los modelos.
x_test = x(5);
y_test = y(5);

% Llama a la funcion models para ajustar los modelos y calcular sus RMSE.
[e_lineal, e_quadratic, e_cubic] = models(x_train, y_train, x_test, y_test);


disp('=== ERRORES RMSE ===');
disp(['Lineal: ', num2str(e_lineal)]);
disp(['Cuadratico: ', num2str(e_quadratic)]);
disp(['Cubico: ', num2str(e_cubic)]);
