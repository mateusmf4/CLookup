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