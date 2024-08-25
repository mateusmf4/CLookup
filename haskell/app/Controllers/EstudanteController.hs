module Controllers.EstudanteController where

import qualified Repository
import Models.Estudante
import Data.Maybe (isJust)

cadastro :: String -> Int -> Bool -> IO (Either String Estudante)
cadastro nome matricula monitor = do
    existe <- isJust <$> Repository.fetchEstudante matricula
    if existe then do
        return $ Left "Estudante com mesma matricula ja existe!"
    else do
        let estudante = Estudante { nome = nome, matricula = matricula, monitor = monitor }
        Repository.saveEstudante estudante
        return $ Right estudante

atualizaMonitor :: Int -> IO (Either String Estudante)
atualizaMonitor matricula = do
    existe <- Repository.fetchEstudante matricula
    if isNothing existe then do
        return $  Left "Estudante não está cadastrado"
    else do
        let Just estudante = existe
        let atualizaMonitor = not (monitor estudante)
        let atualizado = estudante {monitor = atualizaMonitor}
        Repository.saveEstudante atualizado
        return $ Right atualizado

-- método: reservar uma sala
-- método: verificar as salas disponíveis e indisponíveis
-- método: cancelar uma reserva
-- método: atualizar uma reserva