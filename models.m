% FUNCION DE AJUSTE Y COMPARACION DE MODELOS DE REGRESION
% Recibe los datos de entrenamiento y el dato de prueba. Ajusta modelos
% lineal, cuadratico y cubico, y devuelve el RMSE de cada prediccion
function [e_lineal,e_quadratic,e_cubic]=models(x,y,x_test,y_test)

% Muestra los datos de entrenamiento utilizados por la funcion
disp('ENTRE A MODELS');
disp(x);
disp(y);

% REGRESION LINEAL: ajusta un polinomio de grado 1 a los datos
c_linear = polyfit(x, y, 1);
y_fit_linear = polyval(c_linear, x_test); % Predice la tasa de exito para el dato de prueba
e_lineal=RMSE(y_test,y_fit_linear); % Calcula el error entre el valor real y la prediccion

% REGRESION CUADRATICA: ajusta un polinomio de grado 2
c_quadratic = polyfit(x, y, 2);
y_fit_quadratic = polyval(c_quadratic, x_test); % Calcula la prediccion del modelo cuadratico
e_quadratic=RMSE(y_test,y_fit_quadratic); % Calcula el RMSE de la prediccion cuadratica

% REGRESION CUBICA: ajusta un polinomio de grado 3
c_cubic = polyfit(x, y, 3);
y_fit_cubic = polyval(c_cubic, x_test); % Calcula la prediccion del modelo cubico
e_cubic=RMSE(y_test,y_fit_cubic); % Calcula el RMSE de la prediccion cubica

% PREPARACION DE LA GRAFICA COMPARATIVA.
figure; 
hold on; 

domain = min(x):10:max(x_test); % Crea el intervalo de valores donde se dibujaran las curvas

% Muestra los datos de entrenamiento y el dato reservado para prueba
plot(x, y, 'o', 'MarkerSize', 8);
plot(x_test, y_test, 'ks', 'MarkerSize', 8);

% Dibuja las curvas correspondientes a los tres modelos
plot(domain, polyval(c_linear, domain));
plot(domain, polyval(c_quadratic, domain));
plot(domain, polyval(c_cubic, domain));

% Agrega etiquetas, titulo y leyenda para identificar los datos y modelos
xlabel('Poblacion de jugadores');
ylabel('Tasa de exito');
title('Regresion de la tasa de exito');

legend('Entrenamiento', 'Prueba', ...
    ['Lineal: ', num2str(e_lineal)], ...
    ['Cuadratico: ', num2str(e_quadratic)], ...
    ['Cubico: ', num2str(e_cubic)], ...
    'Location', 'best');

grid on; 
hold off; 
end
