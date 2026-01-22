# ESC colour codes. Helpful for powershell 5.1 and the message function in the throbber thingy yeh something like that

# Dark colours
$global:Black = '[30m'
$global:DarkRed = '[31m'
$global:DarkGreen = '[32m'
$global:DarkYellow = '[33m'
$global:DarkBlue = '[34m'
$global:DarkMagenta = '[35m'
$global:DarkCyan = '[36m'
$global:DarkWhite = '[37m' # as far as i know this is literally useless lol just use $global:White instead

# Regular Colours
$global:Gray = '[90m'
$global:Red = '[91m'
$global:Green = '[92m'
$global:Yellow = '[93m'
$global:Blue = '[94m'
$global:Magenta = '[95m'
$global:Cyan = '[96m'
$global:White = '[97m'

# Dark colours (Background)
$global:BlackBG = '[40m'
$global:DarkRedBG = '[41m'
$global:DarkGreenBG = '[42m'
$global:DarkYellowBG = '[43m'
$global:DarkBlueBG = '[44m'
$global:DarkMagentaBG = '[45m'
$global:DarkCyanBG = '[46m'
$global:DarkWhiteBG = '[47m' # Still useless

# Regular Colours (Background)
$global:GrayBG = '[100m'
$global:RedBG = '[101m'
$global:GreenBG = '[102m'
$global:YellowBG = '[103m'
$global:BlueBG = '[104m'
$global:MagentaBG = '[105m'
$global:CyanBG = '[106m'
$global:WhiteBG = '[107m'

$global:Reset = '[39m' # Would rarely use this, can cause issues in powershell 5.1 with the default blue window.
$global:ResetBG = '[49m' # Ditto

# Kon OS purple :D
$global:accent = '[38;5;99m'
$global:accentBG = '[48;5;99m'

$global:ESC = '' # Helpful for any other esc code needed