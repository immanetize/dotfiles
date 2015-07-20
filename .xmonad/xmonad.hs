
-- Import stuff
import XMonad
import qualified XMonad.StackSet as W 
import qualified Data.Map as M
import XMonad.Util.EZConfig(additionalKeys)
import System.Exit
import Graphics.X11.Xlib
import System.IO
 
 
-- actions
import XMonad.Actions.CycleWS
import XMonad.Actions.WindowGo
import qualified XMonad.Actions.Search as S
import XMonad.Actions.Search
import qualified XMonad.Actions.Submap as SM
import XMonad.Actions.GridSelect
 
-- utils
import XMonad.Util.Scratchpad (scratchpadSpawnAction, scratchpadManageHook, scratchpadFilterOutWorkspace)
import XMonad.Util.Run(spawnPipe)
import qualified XMonad.Prompt 		as P
import XMonad.Prompt.Shell
import XMonad.Prompt
 
 
-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
 
-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Reflect
import XMonad.Layout.IM
import XMonad.Layout.Tabbed
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Grid
 
-- Data.Ratio for IM layout
import Data.Ratio ((%))
 
-- Java Fix
import XMonad.Hooks.SetWMName
 
-- Main --
main = do
        xmproc <- spawnPipe "xmobar"  -- start xmobar
    	xmonad 	$ withUrgencyHook NoUrgencyHook $ defaultConfig
        	{ manageHook = myManageHook
        	, layoutHook = myLayoutHook  
		, borderWidth = myBorderWidth
		, normalBorderColor = myNormalBorderColor
		, focusedBorderColor = myFocusedBorderColor
		, keys = myKeys
		, logHook = myLogHook xmproc
        	, modMask = myModMask  
        	, terminal = myTerminal
		, workspaces = myWorkspaces
                , focusFollowsMouse = False
		}
 
 
 
-- hooks
-- automaticly switching app to workspace 
myManageHook :: ManageHook
myManageHook = scratchpadManageHook (W.RationalRect 0.25 0.375 0.5 0.35) <+> ( composeAll . concat $
                [[isFullscreen                  --> doFullFloat
		, className =? "libreoffice-writer" --> doShift "4:doc" 
		, className =?  "Xmessage" 	--> doCenterFloat 
		, className =? "Pcmanfm"	--> doCenterFloat
		, className =?  "Zenity" 	--> doCenterFloat 
		, className =? "feh" 		--> doCenterFloat 
                , className =? "Firefox"        --> doShift "2:web"
                , className =? "Iceweasel"      --> doShift "2:web"
                , className =? "Chromium"       --> doShift "2:web"
                , className =? "Pidgin"         --> doShift "6:chat"
                , className =? "Skype"          --> doShift "6:chat"
		, className =? "VirtualBox"	--> doShift "5:virt"
		, className =? "Gnome-boxes"	--> doShift "5:virt"
		, className =? "Evince" 	--> doShift "4:doc"
		, className =? "Pgadmin3"	--> doShift "7:pg"
		, className =? "Gedit" 		--> doShift "3:code"
       		, className =? "Emacs"	    	--> doShift "3:emacs"
		, className =? "Remote-viewer"  --> doShift "5:virt"
		, className =? "stalonetray" 	--> doIgnore   		
		]]
                        )  <+> manageDocks
 
 
--logHook
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ customPP { ppOutput = hPutStrLn h }

 
 
---- Looks --
---- bar
customPP :: PP
customPP = defaultPP { 
     			    ppHidden = xmobarColor "#00FF00" ""
			  , ppCurrent = xmobarColor "#FF0000" "" . wrap "[" "]"
			  , ppUrgent = xmobarColor "#FF0000" "" . wrap "*" "*"
                          , ppLayout = xmobarColor "#FF0000" ""
                          , ppTitle = xmobarColor "#00FF00" "" . shorten 80
                          , ppSep = "<fc=#0033FF> | </fc>"
                     }
	
 
-- some nice colors for the prompt windows to match the dzen status bar.
myXPConfig = defaultXPConfig                                    
    { 
	font  = "-*-terminus-*-*-*-*-12-*-*-*-*-*-*-u" 
	,fgColor = "#00FFFF"
	, bgColor = "#000000"
	, bgHLight    = "#000000"
	, fgHLight    = "#FF0000"
	, position = Top
    }
 
--- My Theme For Tabbed layout
myTheme = defaultTheme { decoHeight = 16
                        , activeColor = "#a6c292"
                        , activeBorderColor = "#a6c292"
                        , activeTextColor = "#000000"
                        , inactiveBorderColor = "#000000"
                        }
 
--LayoutHook
myLayoutHook  =  onWorkspace "2:web" webL  $  onWorkspace "6:chat" imLayout  $  onWorkspace "9:gimp" gimpL $ onWorkspace "7:vbox" fullL $ standardLayouts 
   where
	standardLayouts =   avoidStruts  $ (tiled |||  reflectTiled ||| Mirror tiled ||| Grid ||| Full) 
 
        --Layouts
	tiled     = smartBorders (ResizableTall 1 (2/100) (1/2) [])
        reflectTiled = (reflectHoriz tiled)
	tabLayout = (tabbed shrinkText myTheme)
	full 	  = noBorders Full
 
        --Im Layout
        imLayout = avoidStruts $ smartBorders $ withIM ratio pidginRoster $ reflectHoriz $ withIM skypeRatio skypeRoster (tiled ||| reflectTiled ||| Grid) where
                chatLayout      = Grid
	        ratio = (1%9)
                skypeRatio = (1%8)
                pidginRoster    = And (ClassName "Pidgin") (Role "buddy_list")
                skypeRoster     = (ClassName "Skype") `And` (Not (Title "Options")) `And` (Not (Role "Chats")) `And` (Not (Role "CallWindowForm"))
 
	--Gimp Layout
	gimpL = avoidStruts $ smartBorders $ withIM (0.11) (Role "gimp-toolbox") $ reflectHoriz $ withIM (0.15) (Role "gimp-dock") Full 
 
	--Web Layout
	webL      = avoidStruts $  tabLayout  ||| tiled ||| reflectHoriz tiled |||  full 
 
        --VirtualLayout
        fullL = avoidStruts $ full
 
 
 
 
 
-------------------------------------------------------------------------------
---- Terminal --
myTerminal :: String
myTerminal = "urxvt"
 
-------------------------------------------------------------------------------
-- Keys/Button bindings --
-- modmask
myModMask :: KeyMask
myModMask = mod4Mask
 
 
 
-- borders
myBorderWidth :: Dimension
myBorderWidth = 1
--  
myNormalBorderColor, myFocusedBorderColor :: String
myNormalBorderColor = "#333333"
myFocusedBorderColor = "#FF0000"
--
 
 
--Workspaces
myWorkspaces :: [WorkspaceId]
myWorkspaces = ["1:shell", "2:web", "3:emacs", "4:doc", "5:virt", "6:chat" ,"7:pg", "8:games", "9:music"] 
--
 
 
--Search engines to be selected :  [google (g), youtube (y) , maps (m), duckduckgo (d) , wikipedia (w), fwiki (f) , wunderground (u),]
--keybinding: hit mod + s + <searchengine>
searchEngineMap method = M.fromList $
       [ ((0, xK_g), method S.google )
       , ((0, xK_y), method S.youtube )
       , ((0, xK_m), method S.maps )
       , ((0, xK_w), method S.wikipedia )
       , ((0, xK_d), method $ S.searchEngine "duckduckgo" "https://duckduckgo.com/?q=" )
       , ((0, xK_f), method $ S.searchEngine "fwiki" "https://fedoraproject.org/wiki/Special:Search?search=" )
       , ((0, xK_u), method $ S.searchEngine "wunderground" "http://www.wunderground.com/cgi-bin/findweather/getForecast?query=")
       , ((0, xK_h), method $ S.searchEngine "github" "https://github.com/search?q=" )
       ]
 

-- keys
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- killing programs
    [ ((modMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modMask .|. shiftMask, xK_c ), kill)
 
    -- opening program launcher / search engine
    , ((modMask , xK_s ), SM.submap $ searchEngineMap $ S.promptSearchBrowser myXPConfig "firefox")
    ,((modMask , xK_p), shellPrompt myXPConfig)
 
 
    -- GridSelect
    , ((modMask, xK_g), goToSelected defaultGSConfig)
 
    -- layouts
    , ((modMask, xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modMask, xK_b ), sendMessage ToggleStruts)
 
    -- floating layer stuff
    , ((modMask, xK_t ), withFocused $ windows . W.sink)
 
    -- refresh'
    , ((modMask, xK_n ), refresh)
 
    -- focus
    , ((modMask, xK_Tab ), windows W.focusDown)
    , ((modMask, xK_j ), windows W.focusDown)
    , ((modMask, xK_k ), windows W.focusUp)
    , ((modMask, xK_m ), windows W.focusMaster)
 
 
    -- swapping
    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j ), windows W.swapDown )
    , ((modMask .|. shiftMask, xK_k ), windows W.swapUp )
 
    -- increase or decrease number of windows in the master area
    , ((modMask , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask , xK_period), sendMessage (IncMasterN (-1)))
 
    -- resizing
    , ((modMask, xK_h ), sendMessage Shrink)
    , ((modMask, xK_l ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_h ), sendMessage MirrorShrink)
    , ((modMask .|. shiftMask, xK_l ), sendMessage MirrorExpand)
 
    -- mpd controls
    , ((0 			, 0x1008ff16 ), spawn "ncmpcpp prev")
    , ((0 			, 0x1008ff17 ), spawn "ncmpcpp next")
    , ((0 			, 0x1008ff14 ), spawn "ncmpcpp play")
    , ((0 			, 0x1008ff15 ), spawn "ncmpcpp pause")
 
    -- scratchpad
    , ((modMask , xK_grave), scratchpadSpawnAction defaultConfig  {terminal = myTerminal}) 
  
    --Programs
    , ((modMask .|.  shiftMask, xK_f ), spawn "pcmanfm")
    , ((modMask .|.  shiftMask, xK_h ), spawn "pidginx")
    , ((modMask .|.  shiftMask, xK_b ), spawn "chromium")
    , ((modMask .|.  shiftMask, xK_g ), spawn "gedit")
    , ((modMask .|.  shiftMask, xK_w ), spawn "libreoffice --writer")
    , ((modMask .|.  shiftMask, xK_x ), spawn "xscreensaver-command -lock")
    , ((modMask .|.  shiftMask, xK_v ), spawn "remote-viewer spice://192.168.1.12:5910")    
    -- volume control
    , ((0 			, 0x1008ff13 ), spawn "amixer -q -c 0 set Master 2dB+")
    , ((0 			, 0x1008ff11 ), spawn "amixer -q -c 0 set Master 2dB-")
    , ((0 			, 0x1008ff12 ), spawn "amixer -q -c 0 set Master toggle")


    -- I hate Java
    , ((modMask .|. controlMask .|. shiftMask, xK_z), setWMName "LG3D") -- @@ Java hack 
 
    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q ), io (exitWith ExitSuccess))
    , ((modMask , xK_q ), restart "xmonad" True)
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-[w,e] %! switch to twinview screen 1/2
    -- mod-shift-[w,e] %! move window to screen 1/2
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_e, xK_w] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]