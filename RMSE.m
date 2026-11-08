% FUNCION PARA CALCULAR EL ERROR CUADRATICO MEDIO DE LA RAIZ (RMSE)
% Recibe los valores reales y los valores estimados por un modelo
% Devuelve una medida del tamano del error de prediccion
function e = RMSE(y,y_fit)

% Calcula la norma de las diferencias entre valores estimados y reales,
% y la normaliza dividiendo por la raiz de la cantidad de observaciones.
e = 1/sqrt(length(y))*norm(y_fit-y);

end
