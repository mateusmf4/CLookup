module Utils where

enumerate :: [a] -> [(Int, a)]
enumerate = zip [0..]
