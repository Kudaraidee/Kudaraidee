if (!(IsLoaded(".\Include.ps1"))) {. .\Include.ps1; RegisterLoaded(".\Include.ps1")}

$Path = '.\Bin\AMD-WildRigMulti\wildrig.exe'
$Uri = 'https://github.com/andru-kun/wildrig-multi/releases/download/0.15.5/wildrig-multi-windows-0.15.5.7z'

$Commands = [PSCustomObject]@{
    "bcd"           = " --algo bcd" #BitcoinDiamond
    "bitcore"       = " --algo bitcore" #Bitcore
    "c11"           = " --algo c11" #C11
    "dedal"         = " --algo dedal" #Dedal
    "exosis"        = " --algo exosis" #Exosis
    "geek"          = " --algo geek" #GeekCash
    "hex"           = " --algo hex" #XDNA
    "hmq1725"       = " --algo hmq1725" #Hmq1725
    "honeycomb"		= " --algo honeycomb" #Honeycomb [BeeNode]
	"lyra2c0ban"    = " --algo lyra2vc0ban" #lyra2c0ban
    "lyra2v3"       = " --algo lyra2v3"
    "phi"           = " --algo phi" #Phi
    "polytimos"     = " --algo polytimos"
    "sha256t"       = " --algo sha256t"
    "sha256q"       = " --algo sha256q"
    "renesis"       = " --algo renesis" #renesis
    "skunkhash"     = " --algo skunkhash" #Skunk
    "sonoa"         = " --algo sonoa" #sonoa
    "timetravel"    = " --algo timetravel" #timetravel
    #"timetravel10" = " --algo timetravel10" #Bitcore
    "tribus"        = " --algo tribus" #Tribus
    "x16r"          = " --algo x16r" #x16r
    "x16rt"         = " --algo x16rt" #GIN x16rt
    "x16s"          = " --algo x16s" #x16s
    "x17"           = " --algo x17" #x17
    "x21s"          = " --algo x21s" #x21s
    "x22i"          = " --algo x22i" #x22i
    "pawelhash"     = " --algo glt-pawelhash" #powelhash
    "jeonghash"     = " --algo glt-jeonghash" #Jeonghash
    "astralhash"    = " --algo glt-astralhash" #Astralhash
    "padihash"      = " --algo glt-padihash" #Padihash
    "rainforest"    = ",d=100 --algo rainforest" #rainforest
	"veil"         = " --algo x16rt" #Veil x16rt
    
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = "AMD"
        Path = $Path
        Arguments = "--api-port=$($Variables.AMDMinerAPITCPPort) --url=$($Pools.(Get-Algorithm($_)).Host):$($Pools.(Get-Algorithm($_)).Port) --user=$($Pools.(Get-Algorithm($_)).User) --pass=$($Pools.(Get-Algorithm($_)).Pass) $($Commands.$_)"
        HashRates = [PSCustomObject]@{(Get-Algorithm($_)) = $Stats."$($Name)_$(Get-Algorithm($_))_HashRate".Live}
        API = "Xmrig"
        Port = $Variables.AMDMinerAPITCPPort
        Wrap = $false
        URI = $Uri
		User = $Pools.(Get-Algorithm($_)).User
    }
}