module Models.LCC where

import GHC.Generics
import Data.Aeson

data LCC = LCC {
    nome :: String,
    numeroSala :: Int,
    qtdComputador :: Int
} deriving (Generic, Show)

instance ToJSON LCC
instance FromJSON LCC