$Path = '.\Bin\NVIDIA-ZEnemy\z-enemy.exe'
$Uri = 'http://kudaraidee.thaiddns.com:69/DechoKocharin/Miner/z-enemy-1.08-release.zip'


$Commands = [PSCustomObject]@{
    Bitcore = ' -i 20'
    Phi = ' -i 20'
    X16R = ' -i 20'
    X16S = ' -i 20'
     
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = "NVIDIA"
        Path = $Path
        Arguments = "-a $_ -o stratum+tcp://$($Pools.(Get-Algorithm($_)).Host):$($Pools.(Get-Algorithm($_)).Port) -u $($Pools.(Get-Algorithm($_)).User) -p $($Pools.(Get-Algorithm($_)).Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{(Get-Algorithm($_)) = $Stats."$($Name)_$(Get-Algorithm($_))_HashRate".Live}
        API = "Ccminer"
        Port = 4068
        Wrap = $false
        URI = $Uri
		User = $Pools.(Get-Algorithm($_)).User
    }
}
