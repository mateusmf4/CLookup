module Models.Professor where

import GHC.Generics
import Data.Aeson

data Professor = Professor {
    nome :: String,
    matricula :: Int,
    prioridade :: Int
} deriving (Generic, Show)

instance ToJSON Professor
instance FromJSON Professor