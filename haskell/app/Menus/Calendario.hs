module Menus.Calendario where

import Data.Time.Clock
import Data.Time.Calendar
import Data.Time.Calendar.Month (Month)
import Control.Monad (forM_)
import Data.List (intercalate)
import System.Console.ANSI (clearScreen)

resetaCor:: String
resetaCor = "\ESC[0m"

amarelo :: String
amarelo = "\ESC[38;5;208m"  

calendario :: [String] 
calendario = [
   "╔══════════════════════════════════════════════════════════╗",
   "║                       CALENDÁRIO                         ║",
   "╚══════════════════════════════════════════════════════════╝"
 ]

menuCalendario :: IO ()
menuCalendario = do
    clearScreen
    putStrLn $ amarelo ++ unlines calendario ++ resetaCor
    today <- utctDay <$> getCurrentTime
    drawCalendar today

diaTextWidth :: Int
diaTextWidth = 5

diaTextHeight :: Int
diaTextHeight = 4

drawDay :: Int -> Bool -> [String]
drawDay nDay filled = [
    "+---+",
    "|" ++ mergeStrings (if filled then "###" else "   ") (show nDay) ++ "|",
    if filled then "|###|" else "|   |",
    "+---+"
    ]
    where
        mergeStrings a b = take (length a - length b) a ++ b

drawCalendar :: Day -> IO ()
drawCalendar day = do
    let month :: Month = dayPeriod day

    let firstWeekDay' = fromEnum $ dayOfWeek $ periodFirstDay month
    -- brasileiro começa semana no domingo! respeita
    -- 1..7 -> 0..6
    let firstWeekDay = firstWeekDay' `mod` 7

    let allWeeks = splitWhen ((== Saturday) . dayOfWeek) (periodAllDays month)

    let thisMonthDay = dayToMonthDay day
    forM_ (zip ([0..] :: [Int]) allWeeks) $ \(i, week) -> do
        let dayCells' = flattenLists $ map (\d -> do
                let monthDay = dayToMonthDay d
                let filled = thisMonthDay == monthDay
                drawDay monthDay filled
                ) week
        -- preenche a primeira semana de espaços pra alinhar
        let dayCells = if i == 0 then map (replicate (diaTextWidth * firstWeekDay) ' ' ++) dayCells' else dayCells'
        putStrLn $ intercalate "\n" dayCells
    
    where
        dayToMonthDay d = let (_, _, x) = toGregorian d in x

splitWhen :: (a -> Bool) -> [a] -> [[a]]
splitWhen condition list =
    case impl [] list of
        ([]:xs) -> reverse xs
        l -> reverse l
    where
        impl [] (x:xs) = impl (if condition x then [[], [x]] else [[x]]) xs
        impl (b:bs) (x:xs) = impl ((if condition x then [[], b ++ [x]] else [b ++ [x]]) ++ bs) xs
        impl buf [] = buf

flattenLists :: [[String]] -> [String]
flattenLists [] = []
flattenLists lists = do
    let l = length $ head lists
    map (\i -> concatMap (!! i) lists) [0..(l-1)]