module Models.Professor where

import GHC.Generics
import Data.Aeson

data Professor = Professor {
    nomeProfessor :: String,
    matriculaProfessor :: Int
} deriving (Generic, Show)

instance ToJSON Professor
instance FromJSON Professor