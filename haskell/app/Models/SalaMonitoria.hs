module Models.SalaMonitoria where

import GHC.Generics
import Data.Aeson

data SalaMonitoria = SalaMonitoria {
    nome :: String,
    numeroSala :: Int,
    ocupada :: Bool -- adicionei esse campo para verificar se uma sala está ocupada ou não p poder trabalhar com o resultado no controller
} deriving (Generic, Show)

instance ToJSON SalaMonitoria
instance FromJSON SalaMonitoria