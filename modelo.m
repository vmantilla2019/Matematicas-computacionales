% MODELO PRINCIPAL DE MATCHMAKING
% Simula la busqueda de jugadores para una partida. La compatibilidad
% depende del rango, la region y el modo de juego seleccionados.

clc; 

flag = true; 

% Muestra el menu hasta que el usuario decida salir
while flag
    disp("===BIENVENIDO===")
    disp("1.entrar al juego");
    disp("2.salir");

    op = input("ingrese una opcion: "); 

    switch op
        case 1
            n = 1500; % Define la cantidad de jugadores generados para la simulacion.

            % Genera aleatoriamente el rango de cada jugador (valores de 1 a 5).
            JRango = randi([1 5], [1 n]);
            % Asigna aleatoriamente una region a cada jugador
            JRegion=randi([1 5], [1 n]);
            % Asigna aleatoriamente un modo de juego a cada jugador
            JModo=randi([1 3], [1 n]);

            disp("===TU PARTIDA===");
            % la region en la que el usuario desea jugar
            disp("Regiones disponibles: 1.America, 2.Europa, 3.Asia, 4.Oceania, 5.Africa");
            MiRegion = input("Elige tu region: ");

            % Solicita el modo de juego y define la cantidad total de participantes
            disp("===TU MODO DE JUEGO===");
            disp("1.Caceria");
            disp("2.Combate por equipos");
            disp("3.Supervivencia");
            MiModo=input("Elige tu modo de juego: ");
            cantidadNecesaria=0; % Inicializa la cantidad de jugadores requerida.

            % Establece el tamano de la partida segun el modo seleccionado.
            if MiModo==1
                cantidadNecesaria=4;
            elseif MiModo==2
                cantidadNecesaria=10;
            elseif MiModo==3
                cantidadNecesaria=25;
            end

            % Reserva la primera posicion de los vectores para representar al usuario.
            JRegion(1) = MiRegion;
            JModo(1) = MiModo;
            MiRango = JRango(1); % Toma como rango del usuario el valor generado en la primera posicion.

            % Calcula la diferencia entre el rango de cada jugador y el del usuario.
            DiferenciaRango = abs(JRango - MiRango);

            % Crea vectores logicos que indican si cada jugador cumple cada restriccion.
            CompatiblesRango = DiferenciaRango <= 1; % Acepta una diferencia de rango maxima de una unidad.
            CompatiblesRegion = JRegion == MiRegion; % Verifica que la region sea la misma.
            CompatiblesModo = JModo == MiModo; % Verifica que el modo de juego sea el mismo.

            % Muestra las caracteristicas asignadas al usuario.
            disp("===JUGADOR===")
            disp(["Rango: ", num2str(MiRango)]);
            disp(["Region: ", num2str(MiRegion)]);
            disp(["Modo: ", num2str(MiModo)]);

            % Combina las tres condiciones: un jugador debe cumplirlas todas
            JugadoresCompatibles = CompatiblesRango & CompatiblesRegion & CompatiblesModo;
            JugadoresCompatibles(1) = false; % Excluye al propio usuario de la lista de candidatos

            % Muestra la cantidad de jugadores que cumplen las restricciones
            disp("Jugadores que cumplen todas las restricciones:");
            disp(sum(JugadoresCompatibles));

            % Comprueba si hay suficientes candidatos para completar la partida sin contar al usuario
            if sum(JugadoresCompatibles)>= (cantidadNecesaria-1)
                disp("Jugadores suficientes...Entrando a la partida...")
                IndicesCompatibles = find(JugadoresCompatibles); % Obtiene las posiciones de los candidatos compatibles

                % Llama a la funcion que selecciona el grupo respetando la compatibilidad de rangos.
                Seleccionados = seleccionarJugadores(JRango, IndicesCompatibles, MiRango, cantidadNecesaria - 1);

                % Muestra los jugadores seleccionados y sus respectivos rangos
                disp("Indices de los jugadores seleccionados:");
                disp("===JUGADORES===")
                disp("Jugador 1(TU) - Rango: "+ MiRango)
                for i = 1:length(Seleccionados)
                    indice = Seleccionados(i); % Obtiene la posicion del jugador seleccionado
                    rango = JRango(indice); % Consulta el rango asociado a esa posicion

                    fprintf("Jugador %d - Rango: %d\n", indice, rango);
                end

                promedio = mean(JRango(Seleccionados)); % Calcula el promedio de los rangos de los jugadores seleccionados
                % Incluye el rango del usuario y los rangos de los
                % jugadores seleccionados para dar un estimado de tiempo
                RangosPartida = [MiRango, JRango(Seleccionados)];

                tiempo = gradi(RangosPartida, MiModo); % Calcula la duracion estimada mediante la funcion de gradiente
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
