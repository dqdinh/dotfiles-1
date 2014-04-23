import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ICCCMFocus
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import System.Exit

myNormalBorderColor  = "#7a7a7a"
myFocusedBorderColor = "#000000"

-- don't forget to follow http://youtrack.jetbrains.com/issue/IDEA-101072

main = xmonad $ defaultConfig {
	      terminal = "urxvt"
              , startupHook = setWMName "LG3D"
              , logHook = takeTopFocus
              , normalBorderColor  = myNormalBorderColor
              , focusedBorderColor = myFocusedBorderColor
              , modMask = mod4Mask
              , keys = keys'
	    }

keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
   [
  -- https://hackage.haskell.org/package/X11-1.6.1.1/docs/Graphics-X11-Types.html
  -- https://hackage.haskell.org/package/X11-1.6.1.1/docs/Graphics-X11-ExtraTypes.html
  -- some defaults copied from http://code.haskell.org/xmonad/XMonad/Config.hs
      ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
    , ((modMask,               xK_p     ), spawn "dmenu_run") -- %! Launch dmenu
    , ((modMask .|. shiftMask, xK_c     ), kill) -- %! Close the focused window
    , ((modMask,               xK_Return), windows W.swapMaster) -- %! Set the focused window as master
    , ((modMask,               xK_minus ), sendMessage Shrink) -- %! Shrink the master area
    , ((modMask,               xK_equal ), sendMessage Expand) -- %! Expand the master area
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
    , ((modMask              , xK_q     ), spawn "xmonad --recompile && xmonad --restart") -- %! Restart xmonad
  ]
    ++
    -- workspaces
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-[',.] %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-[',.] %! Move client to screen 1, 2, or 3
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_quoteright, xK_comma, xK_period] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    ++
    -- my custom additions
    [ 
          ((modMask .|. shiftMask, xK_z), spawn "i3lock -c000000")
        , ((modMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
    ]
