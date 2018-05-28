$PathToZip = "$($env:BUILD_ARTIFACTSTAGINGDIRECTORY)\PublicSite.zip"
$folder = 'wwwroot'
$DestinationPath = $env:BUILD_ARTIFACTSTAGINGDIRECTORY

Add-Type -Assembly System.IO.Compression.FileSystem
$zip = [System.IO.Compression.ZipFile]::OpenRead($PathToZip)

$zip.Entries | Where-Object {$_.FullName -like "$Folder*"} | ForEach-Object {
    $targetPath = $DestinationPath | Join-Path -ChildPath $_.FullName
    if ($_.FullName.EndsWith('/')) {
        New-Item $targetPath -ItemType directory | Out-Null
    }
    else {
        [System.IO.Compression.ZipFileExtensions]::ExtractToFile($_,$targetPath,$true)
    }
} 
$zip.Dispose()
