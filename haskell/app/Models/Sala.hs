module Models.Sala where

import GHC.Generics
import Data.Aeson
import Data.Time (UTCTime)

data Sala = Sala {
    nomeSala :: String,
    qtdeComputador :: Int, 
    qtdeCadeiras :: Int, 
    numSala :: Int,
    tipoSala :: TipoSala, -- Indica a qual tipo de sala se refere,
    reservas :: [Reserva]   -- lista de reservas para a sala. Por meio de cada horario e data agendada, eu poderia verificar se já 
                            -- tem reserva para esse dia e horário ou se ta livre
} deriving (Generic, Show)

data Reserva = Reserva {
    inicio :: UTCTime,  -- data e horário do início de uma reserva
    termino :: UTCTime  -- data e horário do término de uma reserva
} deriving (Generic, Show)
data TipoSala = LCC | Aula | Monitoria
    deriving (Show, Enum, Generic)
    
instance ToJSON Sala
instance FromJSON Sala

instance ToJSON Reserva
instance FromJSON Reserva

instance ToJSON TipoSala
instance FromJSON TipoSala

salasPadroes :: [Sala]
salasPadroes = [
    Sala { nomeSala = "Patos", qtdeComputador = 0, qtdeCadeiras = 10, numSala = 1, tipoSala= Monitoria, reservas=[] },
    Sala { nomeSala = "Cuités", qtdeComputador = 0, qtdeCadeiras = 10, numSala = 2, tipoSala= Monitoria, reservas=[] },
    Sala { nomeSala = "Sousa", qtdeComputador = 0, qtdeCadeiras = 10, numSala = 3, tipoSala= Monitoria, reservas=[] },
    Sala { nomeSala = "LCC 1", qtdeComputador = 40, qtdeCadeiras = 50, numSala = 4, tipoSala= LCC, reservas=[] },
    Sala { nomeSala = "LCC 2", qtdeComputador = 40, qtdeCadeiras = 50, numSala = 5, tipoSala= LCC, reservas=[] },
    Sala { nomeSala = "LCC 3", qtdeComputador = 130, qtdeCadeiras = 145, numSala = 6, tipoSala= LCC, reservas=[] },
    Sala { nomeSala = "CP-01", qtdeComputador = 0, qtdeCadeiras = 45, numSala = 7, tipoSala = Aula, reservas = [] }
 ]

--
--
--
--
--
--
--
--
--
--