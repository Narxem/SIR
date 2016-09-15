import Data.List
import Data.List.Split
import System.IO

type LogEntry = (String, String)
type LogEntryCpt = (LogEntry, Int)

main = do
       logs <- readFile "Log-clients-themes.txt"
       print $ createMatrix (map processLine (lines logs))

processLine :: String -> LogEntry
processLine input = case tail (splitOn ";" input) of
                        [x, y] -> (x, y)
                        _ -> ("", "")

createMatrix :: [LogEntry] -> [(LogEntry, Int)]
createMatrix = auxCreateMatrix []

auxCreateMatrix :: [(LogEntry, Int)] -> [LogEntry] -> [(LogEntry, Int)]
auxCreateMatrix aux [] = aux
auxCreateMatrix aux (entry : entries) =
    case (entry `elemIndex` map fst aux) of
        Nothing -> auxCreateMatrix ((entry, 1) : aux) entries
        Just x  -> auxCreateMatrix (incrementCpt aux x) entries

incrementCpt :: [(LogEntry, Int)] -> Int -> [(LogEntry, Int)]
incrementCpt ((entry, x) : tail) 0 = ((entry, x + 1) : tail)
incrementCpt (item : items) index = item : (incrementCpt items (index - 1))


