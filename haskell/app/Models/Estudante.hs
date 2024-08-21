{-# LANGUAGE OverloadedStrings #-}

module Models.Estudante where

import GHC.Generics
import Data.Version
import Data.Aeson

data Estudante = Estudante {
    nome :: String,
    matricula :: Int,
    monitor :: Bool
} deriving (Generic, Show)

instance ToJSON Estudante
instance FromJSON Estudante where
    parseJSON = withObject "Estudante" $ \v -> Estudante 
        <$> v .: "nome"
        <*> v .: "matricula"
        <*> v .: "monitor"