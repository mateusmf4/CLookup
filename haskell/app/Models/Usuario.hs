-- Esse modelo contem a definição e funções auxiliares para o tipo Usuario.
module Models.Usuario where

import Models.Estudante
import Models.Professor

-- Representa um usuario que está logado no sistema, podendo ser um estudante ou um professor.
-- Serve como uma abstração sobre estudante e professor, visto que ambos possuem caracteristicas em comum.
data Usuario = Est Estudante | Prof Professor deriving (Show)

-- Calcula a prioridade de um usuario logado no sistema,
-- Professor tem prioridade 3, Monitor tem prioridade 2, e Estudante tem prioridade 1.
prioridadeUsuario :: Usuario -> Int
prioridadeUsuario (Prof _) = 3
prioridadeUsuario (Est e) = if monitorEstudante e then 2 else 1

-- Retorna a matricula do usuario logado.
matriculaUsuario :: Usuario -> Int
matriculaUsuario (Prof p) = matriculaProfessor p
matriculaUsuario (Est e) = matriculaEstudante e

-- Retorna a matricula do usuario logado.
nomeUsuario :: Usuario -> String
nomeUsuario (Prof p) = nomeProfessor p
nomeUsuario (Est e) = nomeEstudante e