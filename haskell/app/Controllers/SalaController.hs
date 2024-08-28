module Controllers.SalaController where
import qualified Repository
import Data.Maybe (isJust, isNothing)
import Models.Sala (Sala)



selecionaSala :: String -> Sala -> Bool
selecionaSala nomeDesejado sala
nome sala = nomeDesejado


-- método: reservar uma sala -- maria
-- método: verificar as salas disponíveis e indisponíveis -- gaby
-- método: cancelar uma reserva -- gaby
-- método: atualizar uma reserva -- maria