if (!(IsLoaded(".\Include.ps1"))) {. .\Include.ps1;RegisterLoaded(".\Include.ps1")}

$Path = ".\Bin\NVIDIA-ZEnemy\z-enemy.exe"
$Uri = "ftp://radio.r41.ru/z-enemy.1-28-cuda10.0.zip"

$Commands = [PSCustomObject]@{
"aeriumx" = " -i 20" #AeriumX
"bcd" = " -i 20" #Bcd
"hsr" = "" #Hsr
"phi" = "" #Phi
"phi2" = "" #Phi2 (cryptodredge faster)
"poly" = " -i 20" #Polytimos 
"bitcore" = " -i 20" #Bitcore 
"x16r" = " -i 20" #X16r (2080)
"x16s" = " -i 20" #X16s (2080)
"sonoa" = " -i 20" #SonoA 
"skunk" = " -i 20" #Skunk (trex)
"timetravel" = " -i 20" #Timetravel (fastest)
"tribus" = "" #Tribus (cryptodredge faster)
"c11" = " -i 20" #C11 (2080)
"xevan" = " -i 20" #Xevan 
"x17" = " -i 20" #X17
"hex" = " -i 21" #Hex (2080)
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = "NVIDIA"
        Path = $Path
        Arguments = "-b $($Variables.NVIDIAMinerAPITCPPort) -d $($Config.SelGPUCC) -R 1 -q -a $_ -o stratum+tcp://$($Pools.(Get-Algorithm($_)).Host):$($Pools.(Get-Algorithm($_)).Port) -u $($Pools.(Get-Algorithm($_)).User) -p $($Pools.(Get-Algorithm($_)).Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{(Get-Algorithm($_)) = $Stats."$($Name)_$(Get-Algorithm($_))_HashRate".Day * .99} # substract 1% devfee
        API = "ccminer"
        Port = $Variables.NVIDIAMinerAPITCPPort
        Wrap = $false
        URI = $Uri
        User = $Pools.(Get-Algorithm($_)).User
    }
}
