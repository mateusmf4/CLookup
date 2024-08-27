module Menus.Util where

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
