module Models.SalaMonitoria where

import GHC.Generics
import Data.Aeson

data SalaMonitoria = SalaMonitoria {
    nome :: String,
    numeroSala :: Int
} deriving (Generic, Show)

instance ToJSON SalaMonitoria
instance FromJSON SalaMonitoria