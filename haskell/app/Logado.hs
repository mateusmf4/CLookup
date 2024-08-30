module Logado where

import Models.Estudante
import Models.Professor

data UsuarioLogado = Est Estudante | Prof Professor deriving (Show)

-- Calcula a prioridade de um usuario logado no sistema,
-- Professor tem prioridade 3, Monitor tem prioridade 2, e Estudante tem prioridade 1.
prioridadeUsuario :: UsuarioLogado -> Int
prioridadeUsuario (Prof _) = 3
prioridadeUsuario (Est e) = if monitorEstudante e then 2 else 1

-- Retorna a matricula do usuario logado.
matriculaUsuario :: UsuarioLogado -> Int
matriculaUsuario (Prof p) = matriculaProfessor p
matriculaUsuario (Est e) = matriculaEstudante e

-- Retorna a matricula do usuario logado.
nomeUsuario :: UsuarioLogado -> String
nomeUsuario (Prof p) = nomeProfessor p
nomeUsuario (Est e) = nomeEstudante e