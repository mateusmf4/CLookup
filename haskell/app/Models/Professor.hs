-- modulo que inclui o model do professor no sistema
module Models.Professor where

import GHC.Generics
import Data.Aeson

-- Tipo que representa um professor, com nome e matricula.
data Professor = Professor {
    nomeProfessor :: String,
    matriculaProfessor :: Int
} deriving (Generic, Show)

-- Permite transformar o professor em um objeto JSON.
instance ToJSON Professor
instance FromJSON Professor