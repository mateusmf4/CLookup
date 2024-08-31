-- Model que inclui as principais características que um estudante cadastrado no sistema precisa ter
module Models.Estudante where

-- imports necessários para o funcionamento adequado
import GHC.Generics
import Data.Aeson

-- Varíaveis necessárias para criar um estudante com sucesso no sistema
data Estudante = Estudante {
    nomeEstudante :: String,
    matriculaEstudante :: Int,
    monitorEstudante :: Bool
} deriving (Generic, Show)

-- Realiza a conversão para JSON
instance ToJSON Estudante
instance FromJSON Estudante