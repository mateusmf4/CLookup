module Controllers.EstudanteController where

import qualified Repository
import Models.Estudante
import Data.Maybe (isJust)

cadastro :: String -> Int -> Bool -> IO (Either String Estudante)
cadastro nome matricula monitor = do
    existe <- isJust <$> Repository.fetchEstudante matricula
    if existe then do
        return $ Left "Estudante com mesma matricula já existe!"
    else do
        let estudante = Estudante { nomeEstudante = nome, matriculaEstudante = matricula, monitorEstudante = monitor }
        Repository.saveEstudante estudante
        return $ Right estudante

atualizaMonitor :: Int -> Bool -> IO (Either String Estudante)
atualizaMonitor matricula ehMonitor = do
    busca <- Repository.fetchEstudante matricula
    case busca of
        Nothing -> return $ Left "Estudante não está cadastrado"
        Just estudante -> do
            let atualizado = estudante { monitorEstudante = ehMonitor }
            Repository.saveEstudante atualizado
            return $ Right atualizado

-- método: reservar uma sala
-- método: verificar as salas disponíveis e indisponíveis
-- método: cancelar uma reserva
-- método: atualizar uma reserva