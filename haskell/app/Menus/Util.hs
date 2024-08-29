module Menus.Util where
import Text.Read (readMaybe)
import Control.Monad (forM_)

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
    forM_ (zip [(0 :: Int)..] escolhas) $ \(i, (str, _)) ->
        putStrLn $ show (i + 1) ++ ". " ++ str

    escolherOpcoes $ map snd escolhas

escolherOpcoes :: [IO ()] -> IO ()
escolherOpcoes escolhas = do
    opcao' :: Maybe Int <- readMaybe <$> getLinePrompt "::"
    let opcao = opcao' >>= (\e ->
            if e <= 0 || e > length escolhas
                then Nothing
                else return e
            )
    case opcao of
        Nothing -> putStrLn "Erro: Opção invalida!"
        Just i -> escolhas !! (i - 1)