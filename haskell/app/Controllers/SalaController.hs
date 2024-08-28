module Controllers.SalaController where
import qualified Repository
import Data.Maybe (isJust, isNothing)
import Models.Sala

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

-- Reservando uma sala
reservarSala :: Reserva -> Sala -> Maybe Sala
reservarSala reserva sala 
    | disponibilidadeSala reserva sala = Just (sala { reservas = reserva : reservas sala })
    | otherwise = Nothing

-- Atualizando uma reserva
reservasDaSala :: Sala -> [Reserva]
reservasDaSala sala = reservas sala

atualizarReservaSala :: Reserva -> Reserva -> Sala -> Sala
atualizarReservaSala novaReserva reservaAtual sala = sala { reservas = novasReservas }
  where
    novasReservas = map (\r -> if r == reservaAtual then novaReserva else r) (reservas sala)

atualizaReserva :: Reserva -> Sala -> Bool
atualizaReserva novaReserva sala = do
  let reservasSala = reservasDaSala sala
  putStrLn "Selecione a reserva a ser atualizada:"
  mapM_ (printReserva . show) (zip [1..] reservasSala)
  choice <- getLine
  let reservaIndex = read choice :: Int
  let reservaAtual = reservasSala !! (reservaIndex - 1)
  let novaReservaSala = atualizarReservaSala novaReserva reservaAtual sala
  return (novaReservaSala /= sala)
  
salasMonitoria :: [Sala]
salasMonitoria =
    [
        Sala {nomeSala = "Patos", qtdeComputador = 0, qtdeCadeiras = 10, tipoSala=0, reservas=[]},
        Sala {nomeSala = "Cuités", qtdeComputador = 0, qtdeCadeiras = 10, tipoSala=0, reservas=[]},
        Sala {nomeSala = "Sousa", qtdeComputador = 0, qtdeCadeiras = 10, tipoSala=0, reservas=[]}
    ]
salasLCC :: [Sala]
salasLCC = 
    [
        Sala {nomeSala = "LCC 1", qtdeComputador = 40, qtdeCadeiras = 50, tipoSala=1, reservas=[]},
        Sala {nomeSala = "LCC 2", qtdeComputador = 40, qtdeCadeiras = 50, tipoSala=1, reservas=[]},
        Sala {nomeSala = "LCC 3", qtdeComputador = 130, qtdeCadeiras = 145, tipoSala=1, reservas=[]}

    ]
salaAula :: [Sala]
salaAula = 
    [
        Sala {nomeSala = "CP-01", qtdeComputador = 0, qtdeCadeiras = 45, tipoSala = 2, reservas = []}
    ]

    -- teste teste outro
-- método: reservar uma sala -- maria
-- método: verificar as salas disponíveis e indisponíveis -- gaby
-- método: cancelar uma reserva -- gaby
-- método: atualizar uma reserva -- maria