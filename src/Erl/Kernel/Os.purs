module Erl.Kernel.Os
  ( cmd
  ) where

import Prelude
import Effect (Effect)

cmd :: String -> Effect String
cmd = cmdImpl

foreign import cmdImpl :: String -> Effect String
