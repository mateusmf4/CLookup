-- MenuCores contém as cores que serão usadas na interface de usuário do sistema
module Menus.Cores where

-- reseta as cores para posteriormente poder trocar a cor novamente
reseta :: String
reseta = "\ESC[0m"

-- cor laranja
laranja :: String
laranja = "\ESC[38;5;208m"

-- cor verde
verde :: String
verde = "\ESC[38;5;155m"

-- cor ciano
ciano :: String
ciano = "\ESC[36m"

-- letra em negrito
negrito :: String
negrito = "\ESC[1m"