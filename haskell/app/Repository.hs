module Repository where

-- TODO: talvez botar esse arquivo numa pasta? não sei..

import GHC.Generics (Generic)
import Data.Aeson (FromJSON, ToJSON, decodeFileStrict, encodeFile)
import qualified Data.Aeson.KeyMap as KeyMap
import Data.Aeson.Key (fromString)
import System.Directory (createDirectoryIfMissing)
import System.FilePath (takeDirectory)
import Control.Exception (try, IOException)

import Models.Estudante
import Models.Professor
import Models.Sala

data DatabaseStruct = DatabaseStruct {
    estudantes :: KeyMap.KeyMap Estudante,
    professores :: KeyMap.KeyMap Professor,
    salas :: [Sala]
} deriving (Generic, Show)

instance ToJSON DatabaseStruct
instance FromJSON DatabaseStruct

defaultDatabaseStruct :: DatabaseStruct
defaultDatabaseStruct = DatabaseStruct { estudantes = KeyMap.empty, professores = KeyMap.empty, salas = salasPadroes }

databasePath :: FilePath
databasePath = "./Database/dados.json"

loadDatabase :: IO DatabaseStruct
loadDatabase = do
    dados <- try $ decodeFileStrict databasePath
    case dados of
        Right (Just value) -> return value
        -- caso haja algum erro em ler o arquivo (se não existe),
        -- então cria um database padrão
        Left (_ :: IOException) -> return defaultDatabaseStruct
        _ -> return defaultDatabaseStruct

saveDatabase :: DatabaseStruct -> IO ()
saveDatabase db = do
    -- Garante que a pasta Database existe
    createDirectoryIfMissing True $ takeDirectory databasePath
    encodeFile databasePath db

alterDatabase :: (DatabaseStruct -> DatabaseStruct) -> IO ()
alterDatabase f = do
    db <- loadDatabase
    saveDatabase (f db)

fetchEstudante :: Int -> IO (Maybe Estudante)
fetchEstudante matricula = KeyMap.lookup (fromString $ show matricula) . estudantes <$> loadDatabase

fetchProfessor :: Int -> IO (Maybe Professor)
fetchProfessor matricula = KeyMap.lookup (fromString $ show matricula) . professores <$> loadDatabase

saveEstudante :: Estudante -> IO ()
saveEstudante estudante = alterDatabase (\db -> db { estudantes = KeyMap.insert (fromString $ show $ matriculaEstudante estudante) estudante (estudantes db) })

saveProfessor :: Professor -> IO ()
saveProfessor professor = alterDatabase (\db -> db { professores = KeyMap.insert (fromString $ show $ matriculaProfessor professor) professor (professores db) })


fetchAllSalas :: IO [Sala]
fetchAllSalas = salas <$> loadDatabase