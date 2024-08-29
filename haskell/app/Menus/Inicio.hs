module Menus.Inicio where

import System.Exit (exitSuccess)
import Menus.Util (printBanner, printMenuEscolhas)
import Menus.Cadastro (menuCadastro)
import Menus.Login (menuLogin)
import Menus.Calendario (menuCalendario)

menuInicio :: IO()
menuInicio = do
    printBanner
    putStrLn "Bem vindo ao Sistema CLookup!\n"
    printMenuEscolhas [
        ("Login", menuLogin),
        ("Cadastro", menuCadastro),
        ("Calendario", menuCalendario),
        ("Sair", sair)
        ]
    -- loop infinito, já que o unico jeito de sair é utilizando a opção de sair
    menuInicio

sair :: IO()
sair = do
    putStrLn "Até Mais!"
    exitSuccess