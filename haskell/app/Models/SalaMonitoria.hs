module Models.SalaMonitoria where

import GHC.Generics
import Data.Aeson
import Data.Time (UTCTime)

data SalaMonitoria = SalaMonitoria {
    nome :: String,
    numeroSala :: Int,
    reservas :: [Reserva]   -- Lista de reservas para a sala. Por meio de cada horario e data agendada, eu poderia verificar se já 
                            -- tem reserva para esse dia e horário ou se ta livre
} deriving (Generic, Show)

data Reserva = Reserva {
    inicio :: UTCTime,  -- data e horário do início de uma reserva
    termino :: UTCTime  -- data e horário do término de uma reserva
} deriving (Generic, Show)

instance ToJSON SalaMonitoria
instance FromJSON SalaMonitoria

instance ToJSON Reserva
instance FromJSON Reserva