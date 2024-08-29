module Menus.Login where

import Menus.Util (printBanner, readLnPrompt)
import Menus.Logado (menuLogado)
import Repository (fetchEstudante, fetchProfessor)
import Data.Maybe (isJust)

menuLogin :: IO()
menuLogin = do
    printBanner
    matricula <- readLnPrompt "Digite sua matrícula: "
    estudante <- Repository.fetchEstudante matricula
    professor <- Repository.fetchProfessor matricula
    if isJust estudante then do
        menuLogado estudante
    else if isJust professor then do
        menuLogado professor
    else do
        putStrLn "Não existe usuário com essa matrícula!"
        return()
