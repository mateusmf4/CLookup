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
    salas :: KeyMap.KeyMap Sala
} deriving (Generic, Show)

instance ToJSON DatabaseStruct
instance FromJSON DatabaseStruct

defaultDatabaseStruct :: DatabaseStruct
defaultDatabaseStruct = DatabaseStruct { estudantes = KeyMap.empty, professores = KeyMap.empty, salas = KeyMap.empty }

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

createRooms :: IO ()
createRooms = do
    let lcc1 = Sala {nomeSala = "LCC 1", qtdeComputador = 40, qtdeCadeiras = 50, tipoSala=toEnum 0, reservas=[]}
    let lcc2 = Sala {nomeSala = "LCC 2", qtdeComputador = 40, qtdeCadeiras = 50, tipoSala=toEnum 0, reservas=[]}
    let lcc3 = Sala {nomeSala = "LCC 3", qtdeComputador = 130, qtdeCadeiras = 145, tipoSala=toEnum 0, reservas=[]}
    let cp01  = Sala {nomeSala = "CP-01", qtdeComputador = 0, qtdeCadeiras = 45, tipoSala =toEnum 1, reservas = []}
    let patos = Sala {nomeSala = "Patos", qtdeComputador = 0, qtdeCadeiras = 10, tipoSala=toEnum 2, reservas=[]}
    let cuites = Sala {nomeSala = "Cuités", qtdeComputador = 0, qtdeCadeiras = 10, tipoSala=toEnum 2, reservas=[]}
    let sousa = Sala {nomeSala = "Sousa", qtdeComputador = 0, qtdeCadeiras = 10, tipoSala=toEnum 2, reservas=[]}
    
    alterDatabase (\db -> db { salas = KeyMap.insert (fromString "LCC 1") lcc1 (salas db)})
    alterDatabase (\db -> db { salas = KeyMap.insert (fromString "LCC 2") lcc2 (salas db)})
    alterDatabase (\db -> db { salas = KeyMap.insert (fromString "LCC 3") lcc3 (salas db)})
    alterDatabase (\db -> db { salas = KeyMap.insert (fromString "CP-01") cp01 (salas db)})
    alterDatabase (\db -> db { salas = KeyMap.insert (fromString "Patos") patos (salas db)})
    alterDatabase (\db -> db { salas = KeyMap.insert (fromString "Cuites") cuites (salas db)})
    alterDatabase (\db -> db { salas = KeyMap.insert (fromString "Sousa") sousa (salas db)})

fetchEstudante :: Int -> IO (Maybe Estudante)
fetchEstudante matricula = KeyMap.lookup (fromString $ show matricula) . estudantes <$> loadDatabase

fetchProfessor :: Int -> IO (Maybe Professor)
fetchProfessor matricula = KeyMap.lookup (fromString $ show matricula) . professores <$> loadDatabase

saveEstudante :: Estudante -> IO ()
saveEstudante estudante = alterDatabase (\db -> db { estudantes = KeyMap.insert (fromString $ show $ matricula estudante) estudante (estudantes db) })

saveProfessor :: Professor -> IO ()
saveProfessor professor = alterDatabase (\db -> db { professores = KeyMap.insert (fromString $ show $ matriculaProfessor professor) professor (professores db) })