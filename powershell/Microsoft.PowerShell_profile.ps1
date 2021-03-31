# Dir: $HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1

function croc-cmd { & $HOME\croc\croc.exe $args }
New-Alias -Name croc -Value croc-cmd
