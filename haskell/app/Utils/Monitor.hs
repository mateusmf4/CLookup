module Utils.Monitor where
import GHC.Generics
import Data.Aeson (ToJSON, FromJSON)

data Monitor = Monitor {
    nome :: String,
    matricula :: Int,
    prioridade :: Int
} deriving (Generic, Show)

instance ToJSON Monitor
instance FromJSON Monitor