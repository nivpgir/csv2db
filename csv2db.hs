import System.IO
import System.Environment
import Data.Csv
import Data.ByteString.Lazy as B
import Data.Vector

main :: IO ()
main = do
  args <- getArgs
  h <- case args of
         [] -> error "Must give at least one arg"
         [fpath] -> do handle <- openFile fpath ReadMode
                       return handle
         _ -> error "Too many args"
  fileString <- B.hGetContents h
  writeCsvToDB fileString

writeCsvToDB :: B.ByteString -> IO ()
writeCsvToDB file = print $ ((decode NoHeader file) :: Either String (Vector (String,Int,Int,String,String)))


-- writeTestCsv :: Vector (String,Int,Int,String,String) -> B.ByteString
writeCsv :: FilePath -> [(String,Int,Int,String,String)] -> IO ()
writeCsv fpath records = do
  handle <- openFile fpath WriteMode
  B.hPut handle (encode records)
