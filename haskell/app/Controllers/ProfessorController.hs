-- ProfessorController contem as funções para um professor no sistema.
module Controllers.ProfessorController where

import Models.Professor
import Data.Maybe (isJust)
import qualified Repository

-- Realiza o cadastro de um professor no sistema, atravez de uma matricula e um nome.
cadastro :: String -> Int -> IO (Either String Professor)
cadastro nome matricula = do
    existe <- isJust <$> Repository.fetchUsuario matricula
    if existe then do
        return $ Left "Usuário com mesma matricula ja existe!"
    else do
        let professor = Professor { nomeProfessor = nome, matriculaProfessor = matricula }
        Repository.saveProfessor professor
        return $ Right professor