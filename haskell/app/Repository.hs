-- O modulo Repository é responsavel pelas operações com o banco de dados em formato JSON,
-- como ler e escrever o arquivo quando alterações são feitas.
module Repository where

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

-- Representa a estrutura guardada no banco de dados (arquivo JSON).
data DatabaseStruct = DatabaseStruct {
    estudantes :: KeyMap.KeyMap Estudante,
    professores :: KeyMap.KeyMap Professor,
    salas :: KeyMap.KeyMap Sala
} deriving (Generic, Show)

instance ToJSON DatabaseStruct
instance FromJSON DatabaseStruct

-- O banco de dados padrão, caso o arquivo JSON não esteja presente.
defaultDatabaseStruct :: DatabaseStruct
defaultDatabaseStruct = DatabaseStruct { estudantes = KeyMap.empty, professores = KeyMap.empty, salas = salasPadroes' }
    where salasPadroes' = KeyMap.fromList $ map (\s -> (fromString $ show $ numSala s, s)) salasPadroes

-- Onde é guardado o banco de dados, relativo ao projeto.
databasePath :: FilePath
databasePath = "./Database/dados.json"

-- Lê o banco de dados do disco, e se algum erro ocorre retorna
-- o estado padrão.
loadDatabase :: IO DatabaseStruct
loadDatabase = do
    dados <- try $ decodeFileStrict databasePath
    case dados of
        Right (Just value) -> return value
        -- caso haja algum erro em ler o arquivo (se não existe),
        -- então cria um database padrão
        Left (_ :: IOException) -> return defaultDatabaseStruct
        _ -> return defaultDatabaseStruct

-- Salva um dado estado do banco de dados no disco, em formato JSON.
saveDatabase :: DatabaseStruct -> IO ()
saveDatabase db = do
    -- Garante que a pasta Database existe
    createDirectoryIfMissing True $ takeDirectory databasePath
    encodeFile databasePath db

-- Função auxiliar para ler e modificar o banco de dados de uma vez só.
-- Primeiro argumento é uma função que recebe o banco de dados atual e retorna o seu novo estado,
-- e tal é guardado no disco.
alterDatabase :: (DatabaseStruct -> DatabaseStruct) -> IO ()
alterDatabase f = do
    db <- loadDatabase
    saveDatabase (f db)

-- Procura um estudante no banco de dados pela matricula, se não for encontrado retorna Nothing.
fetchEstudante :: Int -> IO (Maybe Estudante)
fetchEstudante matricula = KeyMap.lookup (fromString $ show matricula) . estudantes <$> loadDatabase

-- Retorna uma lista de todos os estudantes cadastrados no sistema.
fetchAllEstudantes :: IO [Estudante]
fetchAllEstudantes = KeyMap.elems . estudantes <$> loadDatabase

-- Adiciona um novo estudante no sistema, ou sobrescreve um existente dado que ambos tenham a mesma matricula.
saveEstudante :: Estudante -> IO ()
saveEstudante estudante = alterDatabase (\db -> db { estudantes = KeyMap.insert (fromString $ show $ matriculaEstudante estudante) estudante (estudantes db) })

-- Procura um estudante no banco de dados pela matricula, se não for encontrado retorna Nothing.
fetchProfessor :: Int -> IO (Maybe Professor)
fetchProfessor matricula = KeyMap.lookup (fromString $ show matricula) . professores <$> loadDatabase

-- Adiciona um novo professor no sistema, ou sobrescreve um existente dado que ambos tenham a mesma matricula.
saveProfessor :: Professor -> IO ()
saveProfessor professor = alterDatabase (\db -> db { professores = KeyMap.insert (fromString $ show $ matriculaProfessor professor) professor (professores db) })

-- Procura um usuário no banco de dados pela matricula, uma abstração sobre estudante e professor.
-- Se não foi encontrado retorna Nothing.
fetchUsuario :: Int -> IO (Maybe Usuario)
fetchUsuario matricula = do
    est <- fetchEstudante matricula
    case est of
        Just e -> return $ Just $ Est e
        Nothing -> do
            prof <- fetchProfessor matricula
            return $ Prof <$> prof

-- Retorna todas as salas cadastradas no sistema.
fetchAllSalas :: IO [Sala]
fetchAllSalas = KeyMap.elems . salas <$> loadDatabase

-- Procura uma sala pelo seu número de sala, se não retorna Nothing.
fetchSala :: Int -> IO (Maybe Sala)
fetchSala numSalaId = KeyMap.lookup (fromString $ show numSalaId) . salas <$> loadDatabase

-- Adiciona uma nova sala no sistema, ou sobrescreve uma existente dado que ambas tenham o mesmo número de sala.
saveSala :: Sala -> IO ()
saveSala sala = alterDatabase (\db -> db { salas = KeyMap.insert (fromString $ show $ numSala sala) sala (salas db) })
