module Models.SalaAula where

import GHC.Generics
import Data.Aeson

data SalaAula = SalaAula {
    nome :: String,
    numeroSala :: Int,
    qtdCadeiras :: Int
} deriving (Generic, Show)

instance ToJSON SalaAula
instance FromJSON SalaAula