# CLookup - Sistema de reserva de salas do bloco Camilo Lélis

*Projeto para disciplina de PLP 2024.1 na UFCG*

O projeto permite que professores e alunos reservem salas, com diferentes níveis de prioridade.

<img src="https://github.com/user-attachments/assets/d50fb6c1-ea09-43bf-a367-97f151740065"></img>

<p>
  <img width="49%" src="https://github.com/user-attachments/assets/e243a77f-62ff-4ebc-af6a-6f5de1290550"></img>
  <img width="49%" src="https://github.com/user-attachments/assets/bfe52202-30ce-4c98-8497-4c3538ee73c4"></img>
</p>

O mesmo projeto será feito nas linguagens Haskell e Prolog.

## Haskell
O projeto foi desenvolvido usando GHC versão 9.4.8 e cabal versão 3.12.1.0. \
É necessario versões recentes do GHC para rodar o projeto.

Para executar o projeto em haskell, basta executar **dentro da pasta haskell**:
```
cabal install aeson
cabal run
```

No **Windows**, é recomendado rodar `chcp 65001` no terminal antes de rodar o projeto.

## Prolog
O projeto foi desenvolvido usando o SWI-Prolog versão 9.2.7. \
É recomendado usar versões recente desse interpretador.

Para executar o projeto em prolog, basta executar **dentro da pasta prolog**:
```
swipl -q -f init.pl -s Main.pl
```