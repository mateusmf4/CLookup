module Models.Utils.Login where

import qualified Data.ByteString.Lazy as Bs

verificaEstudanteExiste :: Int -> IO Bool
verificaEstudanteExiste matricula = do
    return True

verificaProfessorExiste :: Int -> IO Bool
verificaProfessorExiste matricula = do
    return True

loginEstudante :: Int -> IO Bool
loginEstudante matricula = do
    dadosValidos <- verificaEstudanteExiste matricula
    if not dadosValidos then return True
    else return False

loginProfessor :: Int -> IO Bool
loginProfessor matricula = do
    dadosValidos <- verificaProfessorExiste matricula
    if not dadosValidos then return True
    else return False