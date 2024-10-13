$comps = @"
computer1
computer2
"@

$comps = -split $comps

$script = {
    $userfolders = (Get-ChildItem c:\users).fullname
    taskkill /F /IM "chrome.exe"
    taskkill /F /IM "msedge.exe"
    Start-Sleep -Seconds 5
    foreach ($ufolder in $userfolders){
    
        $Items = @('Archived History',
                    'Cache\*',
                    'Cookies',
                    'History',
                    'Login Data',
                    'Top Sites',
                    'Visited Links',
                    'Web Data')
        $Folder = "$ufolder\appdata\local\Google\Chrome\User Data\Default"
        $Items | % { 
            if (Test-Path "$Folder\$_") {
                Remove-Item "$Folder\$_" -Force -Recurse
            }
        }
    
        # Clear Microsoft Edge cache

        Remove-Item -Path "$ufolder\appdata\local\Packages\Microsoft.MicrosoftEdge_*\AC\#!001\MicrosoftEdge\Cache\*" -Recurse -Force


        # Clear Internet Explorer cache

    }

}


foreach ($comp in $comps) {
    write-host "excuting on $comp"
    invoke-command -ComputerName $comp -ScriptBlock $script
}
