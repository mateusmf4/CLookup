module Models.Estudante where

import GHC.Generics
import Data.Aeson

data Estudante = Estudante {
    nomeEstudante :: String,
    matriculaEstudante :: Int,
    monitorEstudante :: Bool
} deriving (Generic, Show)

instance ToJSON Estudante
instance FromJSON Estudante