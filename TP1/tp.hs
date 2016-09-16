import Data.List
import Data.List.Split
import System.IO

type LogEntry = (String, String)
type LogEntryCpt = (LogEntry, Int)

main = do
       logs <- readFile "Log-clients-themes.txt"
       let matrix = sort $ createMatrix (map processLine (lines logs))
           (users, themes) = createLists matrix in do
                writeFile "users.txt" $ unlines $ users
                writeFile "themes.txt" $ unlines $ themes


processLine :: String -> LogEntry
processLine input = case tail (splitOn ";" input) of
                        [x, y] -> (x, y)
                        _ -> ("", "")

createMatrix :: [LogEntry] -> [LogEntryCpt]
createMatrix = auxCreateMatrix []

auxCreateMatrix :: [(LogEntry, Int)] -> [LogEntry] -> [(LogEntryCpt)]
auxCreateMatrix aux [] = aux
auxCreateMatrix aux (entry : entries) =
    case (entry `elemIndex` map fst aux) of
        Nothing -> auxCreateMatrix ((entry, 1) : aux) entries
        Just x  -> auxCreateMatrix (incrementCpt aux x) entries

incrementCpt :: [(LogEntryCpt)] -> Int -> [(LogEntryCpt)]
incrementCpt ((entry, x) : tail) 0 = ((entry, x + 1) : tail)
incrementCpt (item : items) index = item : (incrementCpt items (index - 1))

createLists :: [LogEntryCpt] -> ([String], [String])
createLists = auxCreateLists [] []

auxCreateLists :: [String] -> [String] -> [LogEntryCpt] -> ([String], [String])
auxCreateLists users themes [] = (users, themes)
auxCreateLists users themes (entry : entries) = 
    let user = fst $ fst entry
        theme = snd $ fst entry in
            if (user `elem` users) then
                if (theme `elem` themes) then
                    auxCreateLists users themes entries
                else
                    auxCreateLists users (theme : themes) entries
            else
                if (theme `elem` themes) then
                    auxCreateLists (user : users) themes entries
                else
                    auxCreateLists (user : users) (theme : themes) entries
        