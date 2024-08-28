module Menus.Util where
import Control.Monad (forM_)
import Text.Read (readMaybe)

printBanner :: IO()
printBanner = do
    putStrLn "\n-------------------- CLookup --------------------\n"

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
    forM_ (zip [0..] escolhas) (\(i :: Int, (escolha, _)) ->
        putStrLn $ show (i + 1) ++ "- " ++ escolha)
    putStrLn ""
    opcao' :: Maybe Int <- readMaybe <$> getLinePrompt "Digite a opção: "
    let opcao = opcao' >>= (\e ->
            if e <= 0 || e > length escolhas
                then Nothing
                else return e
            )
    case opcao of
        Nothing -> putStrLn "Erro: Opção invalida!"
        Just i -> snd (escolhas !! (i - 1))