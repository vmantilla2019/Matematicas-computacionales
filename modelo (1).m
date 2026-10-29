clc;
clear all;
close all;

flag = true;

while flag
    disp("===BIENVENIDO===")
    disp("1.entrar al juego");
    disp("2.salir");

    op = input("ingrese una opcion: ");

    switch op
        case 1
            n = 1500;
            JRango = randi([1 5], [1 n]);
            JRegion=randi([1 5], [1 n]);
            JModo=randi([1 3], [1 n]);

            disp("===TU PARTIDA===");
            disp("Regiones disponibles: 1.America, 2.Europa, 3.Asia, 4.Oceania, 5.Africa");
            MiRegion = input("Elige tu region: ");

            disp("===TU MODO DE JUEGO===");
            disp("1.Caceria");
            disp("2.Combate por equipos");
            disp("3.Supervivencia");
            MiModo=input("Elige tu modo de juego: ");
            cantidadNecesaria=0;

            if MiModo==1
                cantidadNecesaria=4;
            elseif MiModo==2
                cantidadNecesaria=10;
            elseif MiModo==3
                cantidadNecesaria=25;
            end

            JRegion(1) = MiRegion;
            JModo(1) = MiModo;
            MiRango = JRango(1);


            DiferenciaRango = abs(JRango - MiRango);

            CompatiblesRango = DiferenciaRango <= 1;
            CompatiblesRegion = JRegion == MiRegion;
            CompatiblesModo = JModo == MiModo;


            disp("===JUGADOR===")
            disp(["Rango: ", num2str(MiRango)]);
            disp(["Region: ", num2str(MiRegion)]);
            disp(["Modo: ", num2str(MiModo)]);

            JugadoresCompatibles = CompatiblesRango & CompatiblesRegion & CompatiblesModo;
            JugadoresCompatibles(1) = false;

            disp("Jugadores que cumplen todas las restricciones:");
            disp(sum(JugadoresCompatibles));

            if sum(JugadoresCompatibles)>= (cantidadNecesaria-1)
                disp("Jugadores suficientes...Entrando a la partida...")
                IndicesCompatibles = find(JugadoresCompatibles);
                Seleccionados = seleccionarJugadores(JRango, IndicesCompatibles, MiRango, cantidadNecesaria - 1);

                disp("Indices de los jugadores seleccionados:");
                disp("===JUGADORES===")
                disp("Jugador 1(TU) - Rango: "+ MiRango)
                for i = 1:length(Seleccionados)
                    indice = Seleccionados(i);
                    rango = JRango(indice);

                    fprintf("Jugador %d - Rango: %d\n", indice, rango);
                end

                promedio = mean(JRango(Seleccionados));
                % Calcular duracion de la partida
                RangosPartida = [MiRango, JRango(Seleccionados)];

                tiempo = gradi(RangosPartida, MiModo);
                disp(['Rango promedio: ', num2str(promedio)]);
                disp(['Duracion estimada: ', num2str(tiempo), ' minutos']);
            else 
                disp("Jugadores infuficientes...")
            end

        case 2
            disp("Saliendo...")
            flag = false;
        otherwise
            disp("Opcion invalida")
    end
end
