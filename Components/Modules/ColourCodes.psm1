# ESC colour codes. Helpful for powershell 5.1 and the message function in the throbber thingy yeh something like that

# Dark colours
$Black = '[30m'
$DarkRed = '[31m'
$DarkGreen = '[32m'
$DarkYellow = '[33m'
$DarkBlue = '[34m'
$DarkMagenta = '[35m'
$DarkCyan = '[36m'
$DarkWhite = '[37m' # as far as i know this is literally useless lol just use $White instead

# Regular Colours
$Gray = '[90m'
$Red = '[91m'
$Green = '[92m'
$Yellow = '[93m'
$Blue = '[94m'
$Magenta = '[95m'
$Cyan = '[96m'
$White = '[97m'

# Dark colours (Background)
$BlackBG = '[40m'
$DarkRedBG = '[41m'
$DarkGreenBG = '[42m'
$DarkYellowBG = '[43m'
$DarkBlueBG = '[44m'
$DarkMagentaBG = '[45m'
$DarkCyanBG = '[46m'
$DarkWhiteBG = '[47m' # Still useless

# Regular Colours (Background)
$GrayBG = '[100m'
$RedBG = '[101m'
$GreenBG = '[102m'
$YellowBG = '[103m'
$BlueBG = '[104m'
$MagentaBG = '[105m'
$CyanBG = '[106m'
$WhiteBG = '[107m'

$Reset = '[39m' # Would rarely use this, can cause issues in powershell 5.1 with the default blue window.
$ResetBG = '[49m' # Ditto

# Kon OS purple :D
$accent = '[38;5;99m'
$accentBG = '[48;5;99m'

$ESC = '' # Helpful for any other esc code needed