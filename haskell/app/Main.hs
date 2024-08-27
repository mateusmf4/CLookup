module Main where

import Menus.Inicio (menuInicio)
import System.IO (hSetBuffering, BufferMode (NoBuffering), stdout, hGetEncoding, mkTextEncoding, hSetEncoding, stderr, stdin, Handle)

makeSafe :: Handle -> IO ()
makeSafe h = do
  ce' <- hGetEncoding h
  case ce' of
    Nothing -> return ()
    Just ce -> mkTextEncoding (takeWhile (/= '/') (show ce) ++ "//TRANSLIT") >>=
      hSetEncoding h

main :: IO()
main = do
    -- permite imprimir e pegar o input na mesma linha
    hSetBuffering stdout NoBuffering
    -- permite imprimir caracteres unicode no windows
    mapM_ makeSafe [stdout, stdin, stderr]
    menuInicio