# keybinds woah.

switch (([System.Console]::ReadKey($true) | Select-Object -ExpandProperty Key)) {
  d { Write-Host "You pressed D" }
  f { Write-Host "You pressed F" }
  default { Write-Host "NO..." }
}