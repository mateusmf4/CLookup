module Controllers.ProfessorController where
import Models.Professor
import Data.Maybe (isJust)
import qualified Repository

cadastro :: String -> Int -> IO (Either String Professor)
cadastro nome matricula = do
    existe <- isJust <$> Repository.fetchUsuario matricula
    if existe then do
        return $ Left "Usuário com mesma matricula ja existe!"
    else do
        let professor = Professor { nomeProfessor = nome, matriculaProfessor = matricula }
        Repository.saveProfessor professor
        return $ Right professor