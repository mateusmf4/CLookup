-- O módulo Sala tem por intuito modelar a face da Sala no sistema, definindo seus parâmetros e atributos 
module Models.Sala where
-- Importações necessárias para funcionamento do código.
import GHC.Generics
import Data.Aeson
import Data.Time (UTCTime)

-- Definindo os dados necessários para criação de uma sala.
data Sala = Sala {
    -- Código único da sala
    numSala :: Int,
    nomeSala :: String,
    -- Indica a qual tipo de sala se refere
    tipoSala :: TipoSala,
    -- Lista de reservas para a sala
    reservas :: [Reserva]
} deriving (Generic, Show)

-- Definindo os dados necessários para criação de reserva em sala.
data Reserva = Reserva {
    -- matricula de quem fez uma reserva, assim podemos verificar a questão da prioridade
    matricula :: Int,
    -- data e horário do início de uma reserva
    inicio :: UTCTime,
    -- data e horário do término de uma reserva
    termino :: UTCTime
} deriving (Generic, Show, Eq)
data TipoSala = LCC | Aula | Monitoria
    deriving (Show, Enum, Generic)

-- Instâncias do JSON
instance ToJSON Sala
instance FromJSON Sala

instance ToJSON Reserva
instance FromJSON Reserva

instance ToJSON TipoSala
instance FromJSON TipoSala

-- Definindo as salas que o prédio possui por padrão.
salaPadrao :: Sala
salaPadrao = Sala { numSala = -1, nomeSala = "", tipoSala = Aula, reservas = [] }

salasPadroes :: [Sala]
salasPadroes = [
    salaPadrao { numSala = 1, nomeSala = "Patos", tipoSala = Monitoria },
    salaPadrao { numSala = 2, nomeSala = "Cuités", tipoSala = Monitoria },
    salaPadrao { numSala = 3, nomeSala = "Sousa", tipoSala = Monitoria },
    salaPadrao { numSala = 4, nomeSala = "LCC 1", tipoSala = LCC },
    salaPadrao { numSala = 5, nomeSala = "LCC 2", tipoSala = LCC },
    salaPadrao { numSala = 6, nomeSala = "LCC 3", tipoSala = LCC },
    salaPadrao { numSala = 7, nomeSala = "CP-01", tipoSala = Aula }
 ]