module Controllers.SalaController where
import qualified Repository
import Data.Maybe (isJust, isNothing)
import Models.Sala (Sala)


selecionaSala :: String -> Sala -> Bool
selecionaSala nomeDesejado sala
nome sala = nomeDesejado

salasLCC :: [Models.Sala]
salasLCC = 
    [
        Sala {nome = "LCC 1", numeroSala = 4, qtdeComputador = 40, qtdeCadeiras = 50, tipoSala=1, reservas=[]},
        Sala {nome = "LCC 2", numeroSala = 5, qtdeComputador = 40, qtdeCadeiras = 50, tipoSala=1, reservas=[]},
        Sala {nome = "LCC 3", numeroSala = 6, qtdeComputador = 130, qtdeCadeiras = 145, tipoSala=1, reservas=[]}

    ]
salaAula :: [Models.Sala]
salaAula = 
    [
        Sala {nome = "CP-01", numeroSala = 7, qtdeComputador = 0, qtdeCadeiras = 45, tipoSala = 2, reservas = []}
    ]
-- método: reservar uma sala -- maria
-- método: verificar as salas disponíveis e indisponíveis -- gaby
-- método: cancelar uma reserva -- gaby
-- método: atualizar uma reserva -- maria