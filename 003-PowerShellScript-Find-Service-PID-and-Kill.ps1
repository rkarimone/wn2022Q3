#### Find Service with port number and kill it.


# Open Notepad++ write the following code and save it as ..    c:\pscripts\killsvc_port.ps1

param ($port)

$foundProcesses = netstat -ano | findstr :$port
$activePortPattern = ":$port\s.+LISTENING\s+\d+$"
$pidNumberPattern = "\d+$"

IF ($foundProcesses | Select-String -Pattern $activePortPattern -Quiet) {
  $matches = $foundProcesses | Select-String -Pattern $activePortPattern
  $firstMatch = $matches.Matches.Get(0).Value

  $pidNumber = [regex]::match($firstMatch, $pidNumberPattern).Value

  taskkill /pid $pidNumber /f
}


## Now open powershell as admininistrator and run the script as
## cd c:\pscripts\
## ./killsvc_port.ps1 3389    -- this will kill RDP Service
## You can also use this script to other services just by putting port number.


# Manual Method to kill a process
netstat -ano | findstr "PID :PortNumber"
taskkill /PID pidNumber /F










