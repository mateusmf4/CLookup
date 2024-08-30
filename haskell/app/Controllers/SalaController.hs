module Controllers.SalaController where
import  Repository
import Models.Sala
import Data.List (deleteBy, delete)
import Data.Time (UTCTime)

-- Compara duas reservas e verifica se há conflito de horários.
verificaConflito :: Reserva -> Reserva -> Bool
verificaConflito r1 r2 = not (termino r1 <= inicio r2 || termino r2 <= inicio r1)

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



    -- teste teste outro
-- método: reservar uma sala -- maria
-- método: verificar as salas disponíveis e indisponíveis -- gaby
-- método: cancelar uma reserva -- gaby
-- método: atualizar uma reserva -- maria