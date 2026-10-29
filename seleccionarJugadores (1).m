
function Seleccionados = seleccionarJugadores(JRango, IndicesCompatibles, MiRango, cantidadNecesaria)

% Grupos posibles para la partida
GrupoInferior = IndicesCompatibles(JRango(IndicesCompatibles) == MiRango | JRango(IndicesCompatibles) == MiRango - 1);

GrupoSuperior = IndicesCompatibles(JRango(IndicesCompatibles) == MiRango | JRango(IndicesCompatibles) == MiRango + 1);

% Comprobar cuántos jugadores hay en cada grupo
if length(GrupoInferior) >= cantidadNecesaria

    GrupoElegido = GrupoInferior;

elseif length(GrupoSuperior) >= cantidadNecesaria

    GrupoElegido = GrupoSuperior;

else
    Seleccionados = [];
    disp("No hay suficientes jugadores para formar una partida con rangos compatibles.");
    return;
end

% Priorizar jugadores del mismo rango
MismoRango = GrupoElegido(JRango(GrupoElegido) == MiRango);

OtrosRangos = GrupoElegido(JRango(GrupoElegido) ~= MiRango);

% Mezclar aleatoriamente dentro de cada grupo
MismoRango = MismoRango(randperm(length(MismoRango)));
OtrosRangos = OtrosRangos(randperm(length(OtrosRangos)));

OrdenJugadores = [MismoRango, OtrosRangos];

% Elegir la cantidad necesaria
Seleccionados = OrdenJugadores(1:cantidadNecesaria);

end
