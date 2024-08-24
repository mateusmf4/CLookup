module Models.Professor where

import GHC.Generics
import Data.Aeson
import Data.Word (Word8)

data Professor = Professor {
    nomeProfessor :: String,
    matriculaProfessor :: Word8
} deriving (Generic, Show)

instance ToJSON Professor
instance FromJSON Professor