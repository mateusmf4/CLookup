module Controllers.SalaController where
import  Repository
import Models.Sala
import Data.List (deleteBy, delete)
import Data.Time (UTCTime)

-- recebe uma reserva existente e uma lista de reservas e verifica se alguma das reservas na lista conflita com a reserva existente
verificaConflito :: Reserva -> [Reserva] -> Bool
verificaConflito reservaExistente reservas = any (\r -> conflitoReservas reservaExistente r || conflitoReservas r reservaExistente) reservas

-- verifica se duas reservas conflitam, ou seja, se os períodos de início e término se sobrepõem.
conflitoReservas :: Reserva -> Reserva -> Bool
conflitoReservas (Reserva _ inicio1 termino1) (Reserva _ inicio2 termino2) =
  inicio1 < termino2 && inicio2 < termino1

-- Definindo uma função de comparação para deleteBy
reservasIguais :: Reserva -> Reserva -> Bool
reservasIguais r1 r2 = inicio r1 == inicio r2 && termino r1 == termino r2

-- Função para cancelar uma reserva 
cancelarReserva :: Int -> Reserva -> IO ()
cancelarReserva numSalaId reservaParaCancelar = do
    maybeSala <- fetchSala numSalaId
    case maybeSala of
        Just sala -> do
            let reservasAtualizadas = deleteBy reservasIguais reservaParaCancelar (reservas sala)
            let salaAtualizada = sala { reservas = reservasAtualizadas }
            saveSala salaAtualizada
            putStrLn "Reserva cancelada com sucesso!"
        Nothing -> putStrLn "Sala não encontrada."

-- Verificando se uma determinada sala esta disponível.
salaIndisponivel :: UTCTime -> Sala -> Bool
salaIndisponivel tempoAtual sala = any (\r -> inicio r <= tempoAtual && tempoAtual <= termino r) (reservas sala)

-- Retorna todas as salas disponíveis 
salasDisponiveis :: UTCTime -> [Sala] -> [Sala]
salasDisponiveis tempoAtual = filter (not . salaIndisponivel tempoAtual)

-- Retorna todas as salas indisponíveis
salasIndisponiveis :: UTCTime -> [Sala] -> [Sala]
salasIndisponiveis tempoAtual = filter (salaIndisponivel tempoAtual)

-- Reserva uma sala
reservarSala :: Int -> Int -> UTCTime -> UTCTime -> IO ()
reservarSala numSalaId matricula inicio termino = do
  maybeSala <- fetchSala numSalaId
  case maybeSala of
    Just sala -> do
      let reserva = Reserva matricula inicio termino
      if verificaConflito reserva (reservas sala) then
        putStrLn "Sala não disponível para reserva."
      else do
        let reservasAtualizadas = reservas sala ++ [reserva]
        let salaAtualizada = sala { reservas = reservasAtualizadas }
        saveSala salaAtualizada
        putStrLn "Sala reservada com sucesso!"
    Nothing -> putStrLn "Sala não encontrada."

-- Atualiza uma reserva
atualizarReserva :: Int -> Reserva -> IO ()
atualizarReserva numSalaId reservaAtualizada = do
  maybeSala <- fetchSala numSalaId
  case maybeSala of
    Just sala -> do
      let reservasAtualizadas = map (\r -> if inicio r == inicio reservaAtualizada && termino r == termino reservaAtualizada then reservaAtualizada else r) (reservas sala)
      let salaAtualizada = sala { reservas = reservasAtualizadas }
      saveSala salaAtualizada
      putStrLn "Reserva atualizada com sucesso!"
    Nothing -> putStrLn "Sala não encontrada."

-- Lista todas as salas
listarSalas :: IO [Sala]
listarSalas = do
  fetchAllSalas


-- método: reservar uma sala -- maria
-- método: verificar as salas disponíveis e indisponíveis -- gaby
-- método: cancelar uma reserva -- gaby
-- método: atualizar uma reserva -- maria