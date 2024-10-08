-- O módulo Util enquadra algumas funções necessárias ao Menu do sistema.
module Menus.Util where
-- Importações necessárias para o funcionamento do código.
import Text.Read (readMaybe)
import Control.Monad (forM_)
import Data.Time (UTCTime (utctDay), defaultTimeLocale, parseTimeM, formatTime)
import qualified Menus.Cores as Cores

import Models.Sala (Reserva (Reserva))

-- Retorna uma mensagem no console e aguarda a entrada do usuário, retornando essa entrada como String.
getLinePrompt :: String -> IO String
getLinePrompt prompt = do
    putStr prompt
    getLine

-- Retorna uma mensagem no console e aguarda a entrada do usuário, retornando essa entrada para um tipo específico.
readLnPrompt :: Read a => String -> IO a
readLnPrompt prompt = do
    putStr prompt
    readLn

aguardeEnter ::IO ()
aguardeEnter = do
    _ <- getLinePrompt $ Cores.ciano ++ "\nPressione enter para continuar..." ++ Cores.reseta
    return ()

-- Exibe o menu de escolhas do Sistema.
printMenuEscolhas :: [(String, IO ())] -> IO ()
printMenuEscolhas escolhas = do
    forM_ (zip [(0 :: Int)..] escolhas) $ \(i, (str, _)) ->
        putStrLn $ show (i + 1) ++ ". " ++ str

    escolherOpcoes $ map snd escolhas

-- Permite que o usuário escolha uma opção de uma lista de opções e executa a ação correspondente.
escolherOpcoes :: [IO ()] -> IO ()
escolherOpcoes escolhas = do
    opcao' :: Maybe Int <- readMaybe <$> getLinePrompt "::"
    let opcao = opcao' >>= (\e ->
            if e <= 0 || e > length escolhas
                then Nothing
                else return e
            )
    case opcao of
        Nothing -> do
            putStrLn "Erro: Opção invalida!"
            aguardeEnter
        Just i -> escolhas !! (i - 1)

-- Ler uma String em formato de data-hora e a transforma no tipo UTCTime, retornando-o.
lerDataHora :: String -> IO UTCTime
lerDataHora prompt = do
    line <- getLinePrompt prompt
    let time' :: Maybe UTCTime = parseTimeM True defaultTimeLocale "%d/%m/%Y %H:%M" line
    case time' of
        Nothing -> do
            putStrLn "Erro ao ler data. Formato requirido é \"DD/MM/AAAA HH:MM\""
            lerDataHora prompt
        Just time -> return time

-- Formata uma reserva, mostrando o seu tempo inicial e tempo final.
formatarReserva :: Reserva -> String
formatarReserva r = do
    let (Reserva _ inicio termino) = r
    let mesmoDia = utctDay inicio == utctDay termino
    
    let inicioStr = formatTime defaultTimeLocale "%d/%m/%Y %H:%M" inicio
    let terminoStr = if mesmoDia
        then formatTime defaultTimeLocale "%H:%M" termino
        else formatTime defaultTimeLocale "%d/%m/%Y %H:%M" termino
    inicioStr ++ " até " ++ terminoStr