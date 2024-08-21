module Models.Estudante where

import GHC.Generics
import Data.Aeson

data Estudante = Estudante {
    nome :: String,
    matricula :: Int,
    prioridade :: Int
} deriving (Generic, Show)

instance ToJSON Estudante
instance FromJSON Estudante