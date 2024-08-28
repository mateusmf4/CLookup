module Models.Sala where

import GHC.Generics
import Data.Aeson
import Data.Time (UTCTime)

data Sala = Sala {
    nome :: String,
    qtdeComputador :: Int, 
    qtdeCadeiras :: Int, 
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