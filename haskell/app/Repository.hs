module Repository where

-- TODO: talvez botar esse arquivo numa pasta? não sei..

import GHC.Generics (Generic)
import Data.Aeson (FromJSON, ToJSON, decodeFileStrict, encodeFile)
import qualified Data.Aeson.KeyMap as KeyMap
import Models.Estudante
import Data.Aeson.Key (fromString)

newtype DatabaseStruct = DatabaseStruct {
    estudantes :: KeyMap.KeyMap Estudante
} deriving (Generic, Show)

instance ToJSON DatabaseStruct
instance FromJSON DatabaseStruct

defaultDatabaseStruct :: DatabaseStruct
defaultDatabaseStruct = DatabaseStruct { estudantes = KeyMap.empty }

loadDatabase :: IO DatabaseStruct
loadDatabase = do
    dados <- decodeFileStrict "./Database/dados.json"
    case dados of
        Just value -> return value
        Nothing -> return defaultDatabaseStruct

saveDatabase :: DatabaseStruct -> IO ()
saveDatabase db = do
    encodeFile "./Database/dados.json" db

fetchEstudante :: Int -> IO (Maybe Estudante)
fetchEstudante matricula = KeyMap.lookup (fromString $ show matricula) . estudantes <$> loadDatabase

saveEstudante :: Estudante -> IO ()
saveEstudante estudante = do
    dados <- loadDatabase
    saveDatabase dados { estudantes = KeyMap.insert (fromString $ show $ matricula estudante) estudante (estudantes dados) }
    return ()