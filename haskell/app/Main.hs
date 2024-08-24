module Main where

import Menus.Inicio (menuInicio)
import System.IO (hSetBuffering, BufferMode (NoBuffering), stdout)

main :: IO()
main = do
    -- permite imprimir e pegar o input na mesma linha
    hSetBuffering stdout NoBuffering
    menuInicio