module Models.Utils.Cadastro where

import qualified Data.ByteString.Lazy as Bs
import Data.Word (Word8)
import Models.Estudante
import Models.Professor
import qualified Data.Aeson as Aeson
import System.Directory 
import System.FilePath.Posix (takeDirectory)

verificaEstudanteCadastrado :: Word8 -> IO Bool
verificaEstudanteCadastrado matricula = do
    existe <- doesFileExist "./Database/Estudantes/Estudantes.json"
    
    if existe then do
        dados <- Bs.readFile "./Database/Estudantes/Estudantes.json"
        return (Bs.elem matricula dados)
    else return False
    

verificaProfessorCadastrado :: Word8 -> IO Bool
verificaProfessorCadastrado matricula = do
    existe <- doesFileExist "./Database/Professores/Professores.json"
    
    if existe then do
        dados <- Bs.readFile "./Database/Professores/Professores.json"
        return (Bs.elem matricula dados)
    else return False

cadastroEstudante :: String -> Word8 -> IO Bool
cadastroEstudante nome matricula = do
    createDirectoryIfMissing True $ takeDirectory "./Database/Estudantes/"
    
    unico <- verificaEstudanteCadastrado matricula
    if not unico then do
        existe <- doesFileExist "./Database/Estudantes/Estudantes.json"

        if not existe then do
            let dados = Aeson.encode (Estudante {nomeEstudante = nome, matriculaEstudante = matricula, monitor = False})
            Bs.writeFile "./Database/Estudantes/Estudantes.json" dados
            return True
        else do
            let dados = Aeson.encode (Estudante {nomeEstudante = nome, matriculaEstudante = matricula, monitor = False})
            Bs.appendFile "./Database/Estudantes/Estudantes.json" dados
            return True

    else return False

cadastroMonitor :: String -> Word8 -> IO Bool
cadastroMonitor nome matricula = do
    createDirectoryIfMissing True $ takeDirectory "./Database/Estudantes/"
    
    unico <- verificaEstudanteCadastrado matricula
    if not unico then do
        existe <- doesFileExist "./Database/Estudantes/Estudantes.json"

        if not existe then do
            let dados = Aeson.encode (Estudante {nomeEstudante = nome, matriculaEstudante = matricula, monitor = True})
            Bs.writeFile "./Database/Estudantes/Estudantes.json" dados
            return True
        else do
            let dados = Aeson.encode (Estudante {nomeEstudante = nome, matriculaEstudante = matricula, monitor = True})
            Bs.appendFile "./Database/Estudantes/Estudantes.json" dados
            return True
        
    else return False

cadastroProfessor :: String -> Word8 -> IO Bool
cadastroProfessor nome matricula = do
    createDirectoryIfMissing True $ takeDirectory "./Database/Professores/"
    
    unico <- verificaProfessorCadastrado matricula
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