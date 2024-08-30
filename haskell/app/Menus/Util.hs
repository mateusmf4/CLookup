module Menus.Util where
import Text.Read (readMaybe)

getLinePrompt :: String -> IO String
getLinePrompt prompt = do
    putStr prompt
    getLine

readLnPrompt :: Read a => String -> IO a
readLnPrompt prompt = do
    putStr prompt
    readLn

printMenuEscolhas :: [(String, IO ())] -> IO ()
printMenuEscolhas escolhas = do
    opcao' :: Maybe Int <- readMaybe <$> getLinePrompt "::"
    let opcao = opcao' >>= (\e ->
            if e <= 0 || e > length escolhas
                then Nothing
                else return e
            )
    case opcao of
        Nothing -> putStrLn "Erro: Opção invalida!"
        Just i -> snd (escolhas !! (i - 1))