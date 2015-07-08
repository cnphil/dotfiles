--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import Data.Monoid
import System.Exit
import XMonad.Hooks.DynamicLog hiding (xmobar)
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Prompt 
import XMonad.Prompt.Shell (shellPrompt)
import XMonad.Prompt.XMonad (xmonadPrompt)
import qualified XMonad.Actions.CycleWS as CWS

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import XMonad.Hooks.UrgencyHook
import XMonad.Util.NamedWindows (getName)
import XMonad.Layout.IndependentScreens (countScreens)
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Hooks.Place (placeHook, placeFocused, smart, withGaps)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.ManageHook ((<+>))
import XMonad.Actions.FloatKeys (keysMoveWindow, keysResizeWindow, keysAbsResizeWindow, keysMoveWindowTo)
import Codec.Binary.UTF8.String (encodeString)
import Data.Function (on)
import Data.Maybe (fromMaybe)
import Control.Monad (zipWithM_)
import Control.Applicative ((<$>))
import Data.List (intercalate, sortBy)
import Data.Maybe (isJust, catMaybes)
import Data.Ratio ((%))

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "urxvt"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 3

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

myXPConfig = defaultXPConfig                                    
    { 
	font  = "-*-terminus-*-*-*-*-12-*-*-*-*-*-*-u" 
	,fgColor = "#0096d1"
	, bgColor = "#000000"
	, bgHLight    = "#000000"
	, fgHLight    = "#FF0000"
	, position = Top
        , historySize = 512
        , showCompletionOnTab = True
        , historyFilter = deleteConsecutive
    }

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run -fn 'Open Sans-9'")

    -- launch screensaver
    , ((modm .|. shiftMask, xK_l     ), spawn "xscreensaver-command --lock")

    -- run shellPrompt
    , ((modm .|. shiftMask, xK_s     ), shellPrompt myXPConfig)

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

    -- Bring the currently focused window to the top of the stack
    , ((modm,               xK_y     ), windows W.shiftMaster)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), toggleFloat)

    -- Push window to left (floating)
    , ((modm,               xK_i     ), pushFloat (Left ()))

    -- Push window to right (floating)
    , ((modm,               xK_o     ), pushFloat (Right ()))

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_Escape), io (exitWith ExitSuccess))

    -- Restart xmonad
    -- , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    
    -- mod-[, Jump to previous workspace
    
    , ((modm         , xK_bracketleft ), CWS.prevWS)

    -- mod-], Jump to next workspace

    , ((modm         , xK_bracketright), CWS.nextWS)

    -- mod-Esc, Jump to the previously displayed WS
    
    , ((modm              , xK_q      ),  CWS.toggleWS)
    
    -- mod-shift-[, Jump to previous workspace and push current window
    
    , ((modm .|. shiftMask, xK_bracketleft ), CWS.shiftToPrev >> CWS.prevWS)

    -- mod-shift-], Jump to next workspace and push current window

    , ((modm .|. shiftMask, xK_bracketright), CWS.shiftToNext >> CWS.nextWS)
    
    ]


    ++
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++


    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), ((\i->(W.view i).(W.shift i)), shiftMask)]]

    ++

    -- move floating window with keyboard
    [((m .|. c, k), withFocused $ f (d x))
            | (d, k) <- zip [\a->(a, 0), \a->(0, a), \a->(0-a, 0), \a->(0, 0-a)] [xK_l, xK_j, xK_h, xK_k]
            , (f, m) <- zip [keysMoveWindow, \d -> keysResizeWindow d (0, 0)] [modm, modm .|. shiftMask]
            , (c, x) <- zip [controlMask] [40]
    ]

    ++

    -- Move current window to the center
    [((modm .|. controlMask, xK_m     ), placeFocusedToCenter)]

toggleFloat = withFocused (\window -> do
                                floats <- gets (W.floating . windowset)
                                if window `M.member` floats
                                then withFocused $ windows . W.sink
                                else placeFocusedToCenter
                          )

pushFloat side = withFocused (\window -> do
                                resizeFocusedTo 0.4 0.8
                                placeFocused $ smart (sidefactor, 0.5)
                             )
                 where sidefactor = case side of
                                    Left _ -> 0.075
                                    otherwise -> 0.925

resizeFocusedTo wfactor hfactor = withFocused $ \w -> whenX (isClient w) $ withDisplay $ \d -> do
                        ws <- gets windowset
                        wa <- io $ getWindowAttributes d w
                        sc <- fromMaybe (W.current ws) <$> pointScreen (fromIntegral $ wa_x wa) (fromIntegral $ wa_y wa)
                        let sr = screenRect . W.screenDetail $ sc
                        let sr_w = fromIntegral $ rect_width sr
                        let sr_h = fromIntegral $ rect_height sr
                        let resizew = fromIntegral . floor . (*wfactor)
                        let resizeh = fromIntegral . floor . (*hfactor)
                        io $ raiseWindow d w
                        io $ resizeWindow d w (resizew sr_w) (resizeh sr_h)
                        float w

placeFocusedToCenter = do
        resizeFocusedTo 0.505 0.505
        placeFocused $ smart (0.5, 0.5)


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts myLayout'
myLayout' = smartBorders tiled ||| smartBorders (Mirror tiled) ||| smartBorders Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "mpv"            --> doFloat
    , className =? "google-chrome-beta" --> doIgnore -- for kiosks
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

-- Place hook:
-- 
-- Center floating windows.
myPlaceHook = placeHook $ withGaps (16,0,16,0) (smart (0.5,0.5))

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = ewmhDesktopsEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook pps = do
        screens <- (sortBy (compare `on` W.screen) . W.screens) `fmap` gets windowset
        zipWithM_ dynamicLogWithPP' screens pps

myppWithXmobar xmobar = defaultPP {
                     ppOutput = hPutStrLn xmobar
                   , ppTitle = xmobarColor "white" "" . shorten 110
                   -- , ppTitle = (\_ -> "")
                   , ppCurrent = xmobarColor "green" "black" . pad
                   , ppUrgent = xmobarColor "white" "#006600" . pad
                   , ppHidden = pad
                   , ppHiddenNoWindows = \w -> xmobarColor "#444" "" (" " ++ w ++ " ")
                   , ppSep = xmobarColor "#555" "" " / "
                   , ppWsSep = ""
                   , ppLayout = \x -> case x of
                                        "Tall" -> "T"
                                        "Mirror Tall" -> "M"
                                        "Full" -> "F"
                                        _ -> "?"
                   }

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

-- dual screen settings
spawnXmobar screen = spawnPipe . intercalate " " $ options
    where options = [ "xmobar"
                    , "-x"
                    , show screen
                    ]

spawnXmobars nScreens = sequence $ map spawnXmobar $ take nScreens [0..]  
-- The functions dynamicLogWithPP', dynamicLogString', and pprWindowSet' below
-- are similar to their undashed versions, with the difference being that the
-- latter operate on the current screen, whereas the former take the screen to
-- operate on as the first argument.
focusedWindow = maybe Nothing (return . W.focus) . W.stack . W.workspace

dynamicLogWithPP' screen pp = dynamicLogString' screen pp >>= io . ppOutput pp

dynamicLogString' screen pp = do

  winset <- gets windowset
  urgents <- readUrgents
  sort' <- ppSort pp

  -- layout description
  let ld = description . W.layout . W.workspace $ screen

  -- workspace list
  let ws = pprWindowSet' screen sort' urgents pp winset

  -- window title
  wt <- maybe (return "") (fmap show . getName) $ focusedWindow screen

  -- run extra loggers, ignoring any that generate errors.
  extras <- mapM (`catchX` return Nothing) $ ppExtras pp

  return $ encodeString . sepBy (ppSep pp) . ppOrder pp $
             [ ws
             , ppLayout pp ld
             , ppTitle  pp wt
             ]
             ++ catMaybes extras

pprWindowSet' screen sort' urgents pp s = sepBy (ppWsSep pp) . map fmt . sort' $ W.workspaces s
    where this     = W.tag . W.workspace $ screen
          visibles = map (W.tag . W.workspace) (W.current s : W.visible s)

          fmt w = printer pp (W.tag w)
              where printer | this == (head visibles) && W.tag w == this                    = ppUrgent
                            | W.tag w == this                                               = ppCurrent
                            | W.tag w `elem` visibles                                       = ppVisible
                            | any (\x -> maybe False (== W.tag w) (W.findTag x s)) urgents  = \ppC -> ppUrgent ppC . ppHidden ppC
                            | isJust (W.stack w)                                            = ppHidden
                            | otherwise                                                     = ppHiddenNoWindows


sepBy :: String -> [String] -> String
sepBy sep = intercalate sep . filter (not . null)
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    nScreens <- countScreens
    xmobars <- spawnXmobars nScreens
    xmonad conf {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myPlaceHook <+> myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook $ map myppWithXmobar xmobars, 
        startupHook        = myStartupHook >> setWMName "LG3D"
    }

conf = ewmh defaultConfig

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--

