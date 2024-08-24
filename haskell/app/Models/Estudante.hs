{-# LANGUAGE OverloadedStrings #-}

module Models.Estudante where

import GHC.Generics
import Data.Aeson
import Data.Word (Word8)

data Estudante = Estudante {
    nomeEstudante :: String,
    matriculaEstudante :: Word8,
    monitor :: Bool
} deriving (Generic, Show)

instance ToJSON Estudante
instance FromJSON Estudante where
    parseJSON = withObject "Estudante" $ \v -> Estudante 
        <$> v .: "nome"
        <*> v .: "matricula"
        <*> v .: "monitor"