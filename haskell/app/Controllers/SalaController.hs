module Controllers.SalaController where
import qualified Repository
import Data.Maybe (isJust, isNothing)
import Models.Sala (Sala)

-- Compara duas reservas e verifica se há conflito de horários.
verificaConflito :: Reserva -> Reserva -> Bool
verificaConflito r1 r2 = not (termino r1 <= inicio r2 || termino r2 <= inicio r1)

-- Compara duas reservas e verifica se são iguais.
reservasIguais :: Reserva -> Reserva -> Bool
reservasIguais r1 r2 = inicio r1 == inicio r2 && termino r1 == termino r2

-- Verificando se uma determinada sala esta disponível.
disponibilidadeSala :: Reserva -> Sala -> Bool
disponibilidadeSala novaReserva sala = 
    not $ any (verificaConflito novaReserva) 
    (reservas sala)

-- Cancelando uma reserva de Sala.
cancelarReserva :: Reserva -> Sala -> Sala
cancelarReserva reserva sala = sala { reservas = novasReservas }
  where
    novasReservas = deleteBy reservasIguais reserva (reservas sala)

-- Criando salas fixas do Bloco 
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