% PROGRAMA PRINCIPAL DEL SISTEMA DE MATCHMAKING
% Este archivo presenta el menu desde el cual se puede ejecutar el
% modelo de matchmaking, realizar las pruebas experimentales o analizar
% los resultados mediante regresion.

clc;         
clear all;    
close all;    

flag1 = true; 

% Mantiene el menu activo hasta que el usuario seleccione la opcion de salir.
while flag1
    disp("===MENU===")
    disp("1.Modelo de matchmaking");
    disp("2.Evaluación del matchmaking");
    disp("3.Análisis de regresión")
    disp("4.Representacion con algebra lineal")
    disp("5.Analisis de errores")
    disp("6.Analisis de complejidad")
    disp("7.salir")

    op = input("ingrese una opcion: "); 

    % Ejecuta el archivo correspondiente segun la opcion ingresada.
    switch op

        case 1
            run('modelo.m'); % Inicia la simulacion del modelo de matchmaking
        case 2
            run('prueba.m'); % Ejecuta las pruebas con diferentes poblaciones

        case 3
            run('mainRegression.m'); % Inicia el analisis de regresion de los resultados

        case 4
            representacionAlgebraLineal(); % Muestra vectores, matrices y el tensor de jugadores

        case 5
            analisisErrores(); % Muestra el error de optimizacion y las metricas de la regresion

        case 6
            analisisComplejidad(); % Mide los tiempos del matchmaking y muestra el analisis Big-O

        case 7
            disp('Gracias por utilizar el sistema.');
            flag1=false; % Cambia la condicion para finalizar el ciclo del menu

        otherwise
            disp('Opcion no valida.'); % Informa cuando se ingresa una opcion no disponible

    end
end
