% FUNCION DE REPRESENTACION CON ALGEBRA LINEAL
% Representa la poblacion de jugadores con vectores, matrices y un tensor.
% Genera una poblacion con los mismos parametros que modelo.m (n = 1500).
function representacionAlgebraLineal()

n = 1500; % Cantidad de jugadores, igual que en modelo.m

% VECTORES: un vector fila por cada caracteristica de los jugadores.
JRango = randi([1 5], [1 n]);  % Rango de cada jugador (1 a 5)
JRegion = randi([1 5], [1 n]); % Region de cada jugador (1 a 5)
JModo = randi([1 3], [1 n]);   % Modo de juego de cada jugador (1 a 3)

fprintf('Vector de rangos (primeros 10): %s\n', mat2str(JRango(1:10)));
fprintf('Vector de regiones (primeros 10): %s\n', mat2str(JRegion(1:10)));
fprintf('Vector de modos (primeros 10): %s\n', mat2str(JModo(1:10)));

% MATRIZ: cada fila es un jugador y cada columna una caracteristica.
M = [JRango', JRegion', JModo'];
disp(['Matriz de jugadores de tamano ', num2str(size(M, 1)), 'x', num2str(size(M, 2)), ', primeras 5 filas (rango, region, modo):']);
disp(M(1:5, :));

% TENSOR: T(rango, region, modo) = cantidad de jugadores con esa combinacion.
T = zeros(5, 5, 3);
for j = 1:n
    T(JRango(j), JRegion(j), JModo(j)) = T(JRango(j), JRegion(j), JModo(j)) + 1;
end

disp('Tensor de tamano 5x5x3, rebanada del modo 1 (filas rango, columnas region):');
disp(T(:, :, 1));

% Sumar el tensor sobre los rangos deja una matriz region x modo.
disp('Matriz region x modo (suma sobre los rangos, filas region, columnas modo):');
disp(squeeze(sum(T, 1)));

fprintf('Total de jugadores en el tensor: %d (debe ser %d)\n', sum(T(:)), n);

end
