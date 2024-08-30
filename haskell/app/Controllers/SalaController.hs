module Controllers.SalaController where
import qualified Repository
import Models.Sala
import Data.List (deleteBy)

-- Compara duas reservas e verifica se há conflito de horários.
verificaConflito :: Reserva -> Reserva -> Bool
verificaConflito r1 r2 = not (termino r1 <= inicio r2 || termino r2 <= inicio r1)


-- Função para cancelar uma reserva específica
cancelarReserva :: FilePath -> Reserva -> IO ()
cancelarReserva caminho reservaParaCancelar = do
    sala <- lerSalasDeArquivo caminho
    case sala of
        Just s -> do
            let reservasAtualizadas = filter (not . reservasIguais reservaParaCancelar) (reservas s)
            let salaAtualizada = s { reservas = reservasAtualizadas }
            salvarSalasNoArquivo caminho salaAtualizada
            putStrLn "Reserva cancelada com sucesso!"
        Nothing -> putStrLn "Erro ao ler as reservas do arquivo."

-- Verificando se uma determinada sala esta disponível.
salaIndisponivel :: UTCTime -> Sala -> Bool
salaIndisponivel tempoAtual sala = any (\r -> inicio r <= tempoAtual && tempoAtual <= termino r) (reservas sala)

-- Retorna todas as salas disponíveis 
salasDisponiveis :: UTCTime -> [Sala] -> [Sala]
salasDisponiveis tempoAtual = filter (not . salaIndisponivel tempoAtual)

-- Retorna todas as salas indisponíveis
salasIndisponiveis :: UTCTime -> [Sala] -> [Sala]
salasIndisponiveis tempoAtual = filter (salaIndisponivel tempoAtual)

-- Reservando uma sala
reservarSala :: Reserva -> Sala -> Maybe Sala
reservarSala reserva sala
    | disponibilidadeSala reserva sala = Just (sala { reservas = reserva : reservas sala })
    | otherwise = Nothing

    -- teste teste outro
-- método: reservar uma sala -- maria
-- método: verificar as salas disponíveis e indisponíveis -- gaby
-- método: cancelar uma reserva -- gaby
-- método: atualizar uma reserva -- maria