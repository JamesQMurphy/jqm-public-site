$branchNameFull = $env:BUILD_SOURCEBRANCH
$branchName = $env:BUILD_SOURCEBRANCHNAME


if ($branchNameFull -notlike 'refs/heads/releases/*') {
	Write-Output "Branch is not a release branch; skipping setting build number"
	exit
}

function Invoke-TfsWebApi {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string] $Api,
 
        [Parameter(Mandatory=$false)]
        [string] $Method = 'Get',
 
        [Parameter(Mandatory=$false)]
        [string] $Version = '1.0',
 
        [Parameter(Mandatory=$false)]
        [string] $QueryString,
 
        [Parameter(Mandatory=$false)]
        [switch] $Raw
     )
 
    $tfsUrl = $env:SYSTEM_TEAMFOUNDATIONCOLLECTIONURI
    $tfsProjectId = $env:SYSTEM_TEAMPROJECTID
    $authHeaders = @{Authorization = "Bearer $env:SYSTEM_ACCESSTOKEN"}
 
    $url = "$($tfsUrl)$($tfsProjectId)$($Api)?api-version=$Version"
    if (![String]::IsNullOrEmpty($QueryString)) {
        $url = "$url&$QueryString"
    }
    $results = Invoke-WebRequest -Method $Method -UseBasicParsing -Uri $Url -Headers $authHeaders 
    if ($Raw) {
        return $results
    }
    else {
        $retVal = $results.Content | ConvertFrom-Json
        return $retVal
    }
}

function Format-SemVer1 {
    param(
        [Parameter(Mandatory=$true)]
        [int]$Major,
 
        [Parameter(Mandatory=$true)]
        [int]$Minor,
 
        [Parameter(Mandatory=$false)]
        [int]$Patch = 0,
 
        [Parameter(Mandatory=$false)]
        [int]$Build,
 
        [Parameter(Mandatory=$false)]
        [string]$Beta
    )
 
    $stem = "$Major.$Minor.$Patch"
    if ([String]::IsNullOrEmpty($Beta)) {
        if ($Build -eq 0) {
            return $stem
        }
        else {
            return "$stem.$Build"
        }
    }
    else {
        if ($Build -eq 0) {
            return "$stem-$Beta"
        }
        else {
            return "$stem-$Beta-$([String]::Format('{0:D4}',$Build))"
        }
    }
}
 
 
filter ConvertTo-SemVer1 {
    begin {
        $hyphenSplit = [char[]] @('-')
    }
    process {
        $valid = $true
 
        $pieces = $_.ToString().Split($hyphenSplit,2)
        $mmpbString = $pieces[0]
        if ($pieces.Count -eq 2) {$beta = $pieces[1]} else {$beta = ''}
 
        #Major, minor, patch, build
        $mmpb = @(0,0,0,0)
        $i = 0;
        @($mmpbString -split '\.') | ForEach-Object {
            if ($i -lt 4) {
                $result = [int]0
                if ([Int32]::TryParse($_, [ref]$result)) {
                    $mmpb[$i++] = $result
                }
                else {
                    $valid = $false
                }
            }
            else {
                $valid = $false
            }
        }
        $build = $mmpb[3]
 
        #Beta tag
        if (!([String]::IsNullOrEmpty($beta))) {
            $build = 0
 
            # Look to see if the beta tag ends in a four-digit build number (e.g., -0012)
            $regexResult = [Regex]::Match($beta, '(.*)-(\d{1,4})$')
            if ($regexResult.Success) {
                $beta = $regexResult.Groups[1].Value
                $build = [Int32]::Parse($regexResult.Groups[2].Value)
            }
        }
 
        if ($valid) {
            $reduced = Format-SemVer1 -Major $mmpb[0] -Minor $mmpb[1] -Patch $mmpb[2] -Build $build -Beta $beta
 
            #Sort key           
            if ([string]::IsNullOrEmpty($beta)) {
                $betaSort = 'zzzzzzzzzzzzzzzzzz'
            }
            else {
                $betaSort = $beta
            }
            $sortKey = $mmpb[0].ToString("000000000") + $mmpb[1].ToString("000000000") + $mmpb[2].ToString("000000000") + $betaSort + $build.ToString("000000000")
 
            New-Object -TypeName PSObject -Property @{
                'original'=$_;
                'major'=$mmpb[0];
                'minor'=$mmpb[1];
                'patch'=$mmpb[2];
                'build'=$build;
                'beta'=$beta;
                'reduced'=$reduced;
                'sortKey'=$sortKey;
            }
        }
    }
}
 

# Get the previous builds for this build definition
$builds = Invoke-TfsWebApi '/_apis/build/builds' -Version '2.0' -QueryString "`$top=200&definitions=$($env:SYSTEM_DEFINITIONID)" | Select-Object -ExpandProperty Value
Write-Output "$($builds.count) builds found"
$buildNumbers = @($builds | Select-Object -ExpandProperty buildnumber)

# To determine the fourth number, we need to look for builds whose number matches the first three numbers
$pattern = "*$branchName*"
Write-Output "Looking for latest build number that matches the pattern: $pattern"
$latestSemVer = @($buildNumbers) | Where-Object {$_ -like $pattern} | ConvertTo-SemVer1 | Sort-Object sortkey -Descending | Select-Object -First 1
if ($latestSemVer -ne $null) {
    Write-Output "Found build number: $($latestSemVer.original)"
	$newBuildNumber = "$branchName.$($latestSemVer.Build + 1)"
}
else {
    Write-Output "No build number found that matches the pattern: $pattern"
	$newBuildNumber = $branchName
}

# Set the build number
Write-Output "Setting build number to $newBuildNumber"
Write-Output "##vso[build.updatebuildnumber]$newBuildNumber"
