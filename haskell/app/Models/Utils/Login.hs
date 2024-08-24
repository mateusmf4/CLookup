module Models.Utils.Login where

import qualified Data.ByteString.Lazy as Bs
import Data.Word (Word8)

verificaEstudanteExiste :: Word8 -> IO Bool
verificaEstudanteExiste matricula = do
    dados <- Bs.readFile "./Database/Estudantes/Estudantes.json"
    return (Bs.elem matricula dados)

verificaProfessorExiste :: Word8 -> IO Bool
verificaProfessorExiste matricula = do
    dados <- Bs.readFile "./Database/Professores/Professores.json"
    return (Bs.elem matricula dados)

loginEstudante :: Word8 -> IO Bool
loginEstudante matricula = do
    dadosValidos <- verificaEstudanteExiste matricula
    if not dadosValidos then return True
    else return False

loginProfessor :: Word8 -> IO Bool
loginProfessor matricula = do
    dadosValidos <- verificaProfessorExiste matricula
    if not dadosValidos then return True
    else return False