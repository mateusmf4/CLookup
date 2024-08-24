module Models.Utils.Cadastro where

import qualified Data.ByteString.Lazy as Bs
import Data.Maybe
import Models.Estudante
import Models.Professor
import qualified Data.Aeson as Aeson
import System.Directory 
import System.FilePath.Posix (takeDirectory)

verificaEstudanteCadastrado :: Int -> IO Bool
verificaEstudanteCadastrado matricula = do
    existe <- doesFileExist "./Database/Estudantes/Estudantes.json"
    
    if existe then do
        dados <- Bs.readFile "./Database/Estudantes/Estudantes.json"
        let dados2 = Aeson.decode dados :: Maybe Estudante
        return (isJust dados2)
    else return False

cadastroEstudante :: Estudante -> IO Bool
cadastroEstudante estudante = do
    createDirectoryIfMissing True $ takeDirectory "./Database/Estudantes/"
    
    unico <- verificaEstudanteCadastrado (matricula estudante)
    if not unico then do
        let dados = Aeson.encode estudante
        Bs.writeFile "./Database/Estudantes/Estudantes.json" dados
        return True
    else return False

cadastroProfessor :: String -> Int -> IO Bool
cadastroProfessor nome matricula = do
    createDirectoryIfMissing True $ takeDirectory "./Database/Professores/"
    
    let unico = False
    if not unico then do
        existe <- doesFileExist "./Database/Professores/Professores.json"

        if not existe then do
            let dados = Aeson.encode (Professor {nomeProfessor = nome, matriculaProfessor = matricula})
            Bs.writeFile "./Database/Professores/Professores.json" dados
            return True
        else do
            let dados = Aeson.encode (Professor {nomeProfessor = nome, matriculaProfessor = matricula})
            Bs.appendFile "./Database/Professores/Professores.json" dados
            return True
        
    else return False