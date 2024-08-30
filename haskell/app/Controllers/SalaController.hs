module Controllers.SalaController where
import qualified Repository
import Models.Sala
import Data.List (deleteBy)

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

salas :: [Sala]
salas =
    [
        Sala {nomeSala = "Patos", qtdeComputador = 0, qtdeCadeiras = 10, numSala = 1, tipoSala=Monitoria, reservas=[]},
        Sala {nomeSala = "Cuités", qtdeComputador = 0, qtdeCadeiras = 10, numSala = 2, tipoSala=Monitoria, reservas=[]},
        Sala {nomeSala = "Sousa", qtdeComputador = 0, qtdeCadeiras = 10, numSala = 3, tipoSala=Monitoria, reservas=[]},
        Sala {nomeSala = "LCC 1", qtdeComputador = 40, qtdeCadeiras = 50, numSala = 4, tipoSala=LCC, reservas=[]},
        Sala {nomeSala = "LCC 2", qtdeComputador = 40, qtdeCadeiras = 50, numSala = 5, tipoSala=LCC, reservas=[]},
        Sala {nomeSala = "LCC 3", qtdeComputador = 130, qtdeCadeiras = 145, numSala = 6, tipoSala=LCC, reservas=[]},
        Sala {nomeSala = "CP-01", qtdeComputador = 0, qtdeCadeiras = 45, numSala = 7, tipoSala = Aula, reservas = []}
    ]

    -- teste teste outro
-- método: reservar uma sala -- maria
-- método: verificar as salas disponíveis e indisponíveis -- gaby
-- método: cancelar uma reserva -- gaby
-- método: atualizar uma reserva -- maria