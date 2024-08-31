-- modulo principal do sistema
module Main where

-- importa o menu de inicio, funcoes de manipulacao de arquivos e entrada/saida, de handles e de tipos de bufferizacao/handles
import Menus.Inicio (menuInicio)
import System.IO (hSetBuffering, BufferMode (NoBuffering), stdout, hGetEncoding, mkTextEncoding, hSetEncoding, stderr, stdin, Handle)

-- deixa um handle seguro para imprimir caracteres unicode, se nao houver codificação definida, não faz nada, se tiver, cria uma nova codificação de texto
makeSafe :: Handle -> IO ()
makeSafe h = do
  ce' <- hGetEncoding h
  case ce' of
    Nothing -> return ()
    Just ce -> mkTextEncoding (takeWhile (/= '/') (show ce) ++ "//TRANSLIT") >>=
      hSetEncoding h

-- função principal do sistema
main :: IO()
main = do
    -- permite imprimir e pegar o input na mesma linha
    hSetBuffering stdout NoBuffering
    -- permite imprimir caracteres unicode no windows
    mapM_ makeSafe [stdout, stdin, stderr]
    -- chama o menu de início do programa
    menuInicio