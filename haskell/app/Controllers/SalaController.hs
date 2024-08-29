module Controllers.SalaController where
import qualified Repository
import Models.Sala
import Data.List (deleteBy)

-- Compara duas reservas e verifica se há conflito de horários.
verificaConflito :: Reserva -> Reserva -> Bool
verificaConflito r1 r2 = not (termino r1 <= inicio r2 || termino r2 <= inicio r1)

-- Compara duas reservas e verifica se são iguais.
reservasIguais :: Reserva -> Reserva -> Bool
reservasIguais r1 r2 = inicio r1 == inicio r2 && termino r1 == termino r2

-- Verificando se uma determinada sala esta disponível.
disponibilidadeSala :: Reserva -> Sala -> Bool
disponibilidadeSala novaReserva sala = 
    not $ any (verificaConflito novaReserva) 
      (reservas sala)

-- Cancelando uma reserva de Sala.
cancelarReserva :: Reserva -> Sala -> Sala
cancelarReserva reserva sala = sala { reservas = novasReservas }
  where
    novasReservas = deleteBy reservasIguais reserva (reservas sala)

-- Reservando uma sala
reservarSala :: Reserva -> Sala -> Maybe Sala
reservarSala reserva sala 
    | disponibilidadeSala reserva sala = Just (sala { reservas = reserva : reservas sala })
    | otherwise = Nothing

    -- teste teste outro
-- método: reservar uma sala -- maria
-- método: verificar as salas disponíveis e indisponíveis -- gaby
-- método: cancelar uma reserva -- gaby
-- método: atualizar uma reserva -- maria