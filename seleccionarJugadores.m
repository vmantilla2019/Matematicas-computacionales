% FUNCION PARA SELECCIONAR LOS JUGADORES DE UNA PARTIDA
% Recibe los rangos, los indices de los candidatos compatibles, el rango
% del usuario y la cantidad de jugadores adicionales que se necesitan
function Seleccionados = seleccionarJugadores(JRango, IndicesCompatibles, MiRango, cantidadNecesaria)

% Forma dos grupos posibles: jugadores del mismo rango o un rango inferior,
% y jugadores del mismo rango o un rango superior al del usuario
GrupoInferior = IndicesCompatibles(JRango(IndicesCompatibles) == MiRango | JRango(IndicesCompatibles) == MiRango - 1);

GrupoSuperior = IndicesCompatibles(JRango(IndicesCompatibles) == MiRango | JRango(IndicesCompatibles) == MiRango + 1);

% Verifica si alguno de los grupos tiene la cantidad de jugadores requerida
if length(GrupoInferior) >= cantidadNecesaria

    GrupoElegido = GrupoInferior; % Selecciona el grupo que incluye el rango del usuario y el inmediatamente inferior

elseif length(GrupoSuperior) >= cantidadNecesaria

    GrupoElegido = GrupoSuperior; % Si el anterior no alcanza, selecciona el grupo con el rango inmediatamente superior

else
    Seleccionados = []; % Devuelve un vector vacio cuando ningun grupo puede completar la partida
    disp("No hay suficientes jugadores para formar una partida con rangos compatibles.");
    return; 
end

% Separa los jugadores que tienen exactamente el mismo rango del usuario
MismoRango = GrupoElegido(JRango(GrupoElegido) == MiRango);

% Obtiene los jugadores del grupo elegido que tienen un rango diferente
OtrosRangos = GrupoElegido(JRango(GrupoElegido) ~= MiRango);

% Aleatoriza el orden de los jugadores dentro de cada categoria
MismoRango = MismoRango(randperm(length(MismoRango)));
OtrosRangos = OtrosRangos(randperm(length(OtrosRangos)));

% Construye una lista poniendo primero a los jugadores del mismo rango
OrdenJugadores = [MismoRango, OtrosRangos];

% Toma de la lista ordenada la cantidad de jugadores que necesita la partida
Seleccionados = OrdenJugadores(1:cantidadNecesaria);

end
