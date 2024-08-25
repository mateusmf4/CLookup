module Menus.Calendario where

import Data.Time.Clock
import Data.Time.Calendar
import Data.Time.Calendar.Month (Month)
import Control.Monad (forM_, when)
import Text.Printf (printf)

showToday :: IO ()
showToday = do
    today <- utctDay <$> getCurrentTime
    drawCalendar today

drawCalendar :: Day -> IO ()
drawCalendar day = do
    let (_, _, todayDay) = toGregorian day
    let month :: Month = dayPeriod day
    let firstWeekDay' = fromEnum $ dayOfWeek $ periodFirstDay month
    -- brasileiro começa semana no domingo! respeita
    -- 1..7 -> 0..6
    let firstWeekDay = firstWeekDay' `mod` 7
    putStr $ replicate (3 * firstWeekDay) ' '
    forM_ (periodAllDays month) $ \d -> do
        let x = dayOfWeek d
        let (_, _, nDay) = toGregorian d
        if nDay == todayDay
            then printf "__ "
            else printf "%2d " nDay
        when (x == Saturday) $ putStrLn ""