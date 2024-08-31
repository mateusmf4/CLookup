-- A modulo SalaController tem por intuito fornecer as funções para controlar e manipular os serviços de Sala no sistema.
module Controllers.SalaController where
-- Importações necessárias para o funcionamento do código.
import Repository
import Models.Sala
import Data.List (delete, sortBy)
import Data.Time (UTCTime)
import Models.Usuario

-- Retorna todas as reservas que estão conflitando com a reserva passada
reservasConflitantes :: Reserva -> [Reserva] -> [Reserva]
reservasConflitantes reserva = filter (seReservaConflita reserva)

-- Verifica se duas reservas conflitam, ou seja, se os períodos de início e término se sobrepõem.
seReservaConflita :: Reserva -> Reserva -> Bool
seReservaConflita (Reserva _ inicio1 termino1) (Reserva _ inicio2 termino2) =
    not (termino1 <= inicio2 || inicio1 >= termino2)
    
-- Reserva uma sala
reservarSala :: Int -> Usuario -> UTCTime -> UTCTime -> IO (Either String Sala)
reservarSala numSalaId usuario inicio termino = do
    maybeSala <- fetchSala numSalaId
    case maybeSala of
        Nothing -> return $ Left "Sala não encontrada."
        Just sala -> do
            let reserva = Reserva (matriculaUsuario usuario) inicio termino

            let conflitos' = reservasConflitantes reserva (reservas sala)
            conflitos <- mapM (\r -> do
                maybeUser <- fetchUsuario (matricula r)
                -- Caso o usuario não existe por algum motivo, toma prioridade -1
                let prioridade = maybe (-1) prioridadeUsuario maybeUser
                return (prioridade, r)
                ) conflitos'
            
            let minhaPrioridade = prioridadeUsuario usuario
            -- Se o usuario tem prioridade sobre todas as reservas conflitantes
            let temPrioridade = all (\(p, _) -> minhaPrioridade > p) conflitos
            if not temPrioridade then
                return $ Left "Sala não disponível para reserva."
            else do
                -- Remove todas as reservas conflitantes
                let reservasAtualizadas = reserva : filter (`notElem` conflitos') (reservas sala)
                let salaAtualizada = sala { reservas = reservasAtualizadas }
                saveSala salaAtualizada
                return $ Right salaAtualizada

-- Função para cancelar uma reserva 
cancelarReserva :: Int -> Reserva -> IO (Either String Sala)
cancelarReserva numSalaId reservaParaCancelar = do
    maybeSala <- fetchSala numSalaId
    case maybeSala of
        Nothing -> return $ Left "Sala não encontrada."
        Just sala -> do
            if reservaParaCancelar `notElem` reservas sala
                then return $ Left "Reserva não existente."
                else do 
                    let reservasAtualizadas = delete reservaParaCancelar (reservas sala)
                    let salaAtualizada = sala { reservas = reservasAtualizadas }
                    saveSala salaAtualizada
                    return $ Right salaAtualizada

-- Lista todas as salas
listarSalas :: IO [Sala]
listarSalas = do
    fetchAllSalas

-- Retorna uma sala baseado no seu número de sala, se não for encontrada retorna um erro.
getSala :: Int -> IO (Either String Sala)
getSala nSala = do
    maybeSala <- fetchSala nSala
    case maybeSala of
        Nothing -> return $ Left "Sala não encontrada."
        Just sala -> return $ Right sala

-- Retorna todas as reservas de uma sala que estão dentro de uma faixa de tempo.
-- As reservas são retornadas ordenadas pelo tempo de inicio.
salaReservasEmFaixa :: Sala -> UTCTime -> UTCTime -> [Reserva]
salaReservasEmFaixa sala inicio termino = do
    let rs = reservasConflitantes (Reserva (-1) inicio termino) (reservas sala)
    sortBy (\(Reserva _ i1 _) (Reserva _ i2 _) -> compare i1 i2) rs