module Menus.Util where
import Control.Monad (forM_)
import Text.Read (readMaybe)

resetaCor:: String
resetaCor = "\ESC[0m"

amarelo :: String
amarelo = "\ESC[38;5;208m"  

menu :: [String]
menu = [
        "╔═══════════════════════════════════════════════════════════════════════════════╗",
        "║                                                                               ║",
        "║                 ______  __                 __               _______           ║",
        "║               .' ___  |[  |               [  |  _          |_   __ |          ║",
        "║             / .'   |_| | |  .--.    .--.  | | / ] __   _    | |__) |          ║",
        "║             | |        | |/ .'`| |/ .'`| || '' < [  | | |   |  ___/           ║",
        "║             | `.___.'| | || |__. || |__. || |`| | | |_/ |, _| |_              ║",
        "║              `.____ .'[___]'.__.'  '.__.'[__|  |_]'.__.'_/|_____|             ║",
        "║                                                                               ║",
        "║       Menu:                                                                   ║",
        "║          1. Login                                                             ║",
        "║          2. Cadastro                                                          ║",
        "║          3. Calendário                                                        ║",
        "║          4. Sair                                                              ║",
        "║                                                                               ║",
        "║                                                          Digite a opção:      ║",
        "╚═══════════════════════════════════════════════════════════════════════════════╝"
    ]

printBanner :: IO()
printBanner = do
    putStrLn $ amarelo ++ unlines menu ++ resetaCor
    

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