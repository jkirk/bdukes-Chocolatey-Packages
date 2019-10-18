import-module au

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri 'https://www.linqpad.net/Download.aspx'

    $re = '<td[^>]*>\s*(5\.(?:\d+\.?))+\s*</td>'

    $versionMatches = $download_page | select-string -Pattern $re
    $versionMatch = $versionMatches.Matches[0]
    $version = $versionMatch.Groups[1].Value

    $Latest = @{ URL32 = 'https://www.linqpad.net/GetFile.aspx?LINQPad5-AnyCPU.zip'; Version = $version }
    return $Latest
}

update
