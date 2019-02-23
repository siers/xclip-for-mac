{-# LANGUAGE OverloadedStrings #-}

import Control.Monad
import Data.ByteString
import Data.Maybe
import GHC.IO.Handle
import Prelude hiding (null)
import System.Environment
import System.IO
import System.Process
import qualified Data.List as L

transferLimit = 1000000

transfer :: Handle -> Handle -> ByteString -> IO ()
transfer from to init = do
  hPut to init
  more <- hGet from transferLimit
  when (not $ null more) (transfer from to more)

paste :: IO ()
paste = do
  (_, _, _, ph) <- createProcess (proc "pbpaste" [])
  () <$ waitForProcess ph

input :: IO ByteString
input = do
  args <- getArgs
  if isJust $ L.find (== "-o") args
  then return ""
  else hGet stdin transferLimit

main = do
  buf <- input

  if null buf
  then paste
  else do
    (Just hin, _, _, _) <- createProcess (proc "pbcopy" []) { std_in = CreatePipe }
    transfer stdin hin buf
    hClose hin
