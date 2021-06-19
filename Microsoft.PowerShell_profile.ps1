function GoAdmin { start-process pwsh –verb runAs }

Import-Module oh-my-posh
Import-Module GuiCompletion
Import-Module PSReadLine

Set-Alias -Name rs -Value rust-script

Set-PoshPrompt -Theme ~/Documents/PowerShell/Modules/oh-my-posh/3.163.0/themes/eparadox.omp.json
$Global:PoshSettings.EnableToolTips = $true

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+Spacebar -ScriptBlock { Invoke-GuiCompletion }
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -EditMode Vi
