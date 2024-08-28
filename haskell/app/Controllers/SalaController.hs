module Controllers.SalaController where
import qualified Repository
import Data.Maybe (isJust, isNothing)
import Models.Sala (Sala)


selecionaSala :: String -> Sala -> Bool
selecionaSala nomeDesejado sala
nome sala = nomeDesejado

salasMonitoria :: [Models.Sala]
salasMonitoria =
    [
        Sala {nome = "Patos", qtdeComputador = 0, qtdeCadeiras = 10, tipoSala=0, reservas=[]},
        Sala {nome = "Cuités", qtdeComputador = 0, qtdeCadeiras = 10, tipoSala=0, reservas=[]},
        Sala {nome = "Sousa", qtdeComputador = 0, qtdeCadeiras = 10, tipoSala=0, reservas=[]}
    ]
salasLCC :: [Models.Sala]
salasLCC = 
    [
        Sala {nome = "LCC 1", qtdeComputador = 40, qtdeCadeiras = 50, tipoSala=1, reservas=[]},
        Sala {nome = "LCC 2", qtdeComputador = 40, qtdeCadeiras = 50, tipoSala=1, reservas=[]},
        Sala {nome = "LCC 3", qtdeComputador = 130, qtdeCadeiras = 145, tipoSala=1, reservas=[]}

    ]
salaAula :: [Models.Sala]
salaAula = 
    [
        Sala {nome = "CP-01", qtdeComputador = 0, qtdeCadeiras = 45, tipoSala = 2, reservas = []}
    ]
-- método: reservar uma sala -- maria
-- método: verificar as salas disponíveis e indisponíveis -- gaby
-- método: cancelar uma reserva -- gaby
-- método: atualizar uma reserva -- maria