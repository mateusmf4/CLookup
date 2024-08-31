-- EstudanteController contém as princiais funções de um estudante que utiliza o sistema
module Controllers.EstudanteController where

-- módulos necessários para o funcionamento
import qualified Repository
import Models.Estudante
import Data.Maybe (isJust)

-- Realiza o cadastro de um estudante no sistema
cadastro :: String -> Int -> Bool -> IO (Either String Estudante)
cadastro nome matricula monitor = do
    existe <- isJust <$> Repository.fetchUsuario matricula
    if existe then do
        return $ Left "Usuário com mesma matricula já existe!"
    else do
        let estudante = Estudante { nomeEstudante = nome, matriculaEstudante = matricula, monitorEstudante = monitor }
        Repository.saveEstudante estudante
        return $ Right estudante

-- Função que torna um estudante monitor ou que retira o cargo de monitor de um determinado estudante
atualizaMonitor :: Int -> Bool -> IO (Either String Estudante)
atualizaMonitor matricula ehMonitor = do
    busca <- Repository.fetchEstudante matricula
    case busca of
        Nothing -> return $ Left "Estudante não está cadastrado"
        Just estudante -> do
            let atualizado = estudante { monitorEstudante = ehMonitor }
            Repository.saveEstudante atualizado
            return $ Right atualizado

-- Retorna todos os estudantes que foram cadastrados no sistema
listarEstudantes :: IO [Estudante]
listarEstudantes = Repository.fetchAllEstudantes
