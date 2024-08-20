module Modules.MenuPrincipal where

printar :: IO()
printar = do
    putStrLn ("--------------------" ++ " CPBooking " ++ "--------------------\n")
    putStrLn "Digite a opção desejada:\n"
    putStrLn "1- Cadastro"
    putStrLn "2- Visualizar reservas"
    putStrLn "3- Disponibilidade de reservas" 
    putStrLn "4- Reservar de sala" 
    putStrLn "5- Cancelamento de reserva" 
    putStrLn "6- Sair\n" 
    putStrLn "Digite a opção: "