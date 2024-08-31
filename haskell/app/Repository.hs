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
import Models.Usuario

data DatabaseStruct = DatabaseStruct {
    estudantes :: KeyMap.KeyMap Estudante,
    professores :: KeyMap.KeyMap Professor,
    salas :: KeyMap.KeyMap Sala
} deriving (Generic, Show)

instance ToJSON DatabaseStruct
instance FromJSON DatabaseStruct

defaultDatabaseStruct :: DatabaseStruct
defaultDatabaseStruct = DatabaseStruct { estudantes = KeyMap.empty, professores = KeyMap.empty, salas = salasPadroes' }
    where salasPadroes' = KeyMap.fromList $ map (\s -> (fromString $ show $ numSala s, s)) salasPadroes

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

fetchAllEstudantes :: IO [Estudante]
fetchAllEstudantes = KeyMap.elems . estudantes <$> loadDatabase

saveEstudante :: Estudante -> IO ()
saveEstudante estudante = alterDatabase (\db -> db { estudantes = KeyMap.insert (fromString $ show $ matriculaEstudante estudante) estudante (estudantes db) })

fetchProfessor :: Int -> IO (Maybe Professor)
fetchProfessor matricula = KeyMap.lookup (fromString $ show matricula) . professores <$> loadDatabase

saveProfessor :: Professor -> IO ()
saveProfessor professor = alterDatabase (\db -> db { professores = KeyMap.insert (fromString $ show $ matriculaProfessor professor) professor (professores db) })

fetchUsuario :: Int -> IO (Maybe Usuario)
fetchUsuario matricula = do
    est <- fetchEstudante matricula
    case est of
        Just e -> return $ Just $ Est e
        Nothing -> do
            prof <- fetchProfessor matricula
            return $ Prof <$> prof

fetchAllSalas :: IO [Sala]
fetchAllSalas = KeyMap.elems . salas <$> loadDatabase

fetchSala :: Int -> IO (Maybe Sala)
fetchSala numSalaId = KeyMap.lookup (fromString $ show numSalaId) . salas <$> loadDatabase

saveSala :: Sala -> IO ()
saveSala sala = alterDatabase (\db -> db { salas = KeyMap.insert (fromString $ show $ numSala sala) sala (salas db) })
