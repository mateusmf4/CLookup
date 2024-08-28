module Menus.Login where

import Menus.Util (printBanner, readLnPrompt)
import Menus.Logado (menuLogado)
import Repository (fetchEstudante, fetchProfessor)
import Data.Maybe (isJust)

menuLogin :: IO()
menuLogin = do
    printBanner
    matricula <- readLnPrompt "Digite sua matrícula: "
    search <- searchUser matricula
    if search then do
        menuLogado True
    else do
        putStrLn "Não existe usuário com essa matrícula!"
        return()

searchUser :: Int -> IO Bool
searchUser matricula = do
    existeEstudante <- isJust <$> Repository.fetchEstudante matricula
    existeProfessor <- isJust <$> Repository.fetchProfessor matricula
    if existeEstudante || existeProfessor then do
        return True
    else do
        return False