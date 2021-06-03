$Computers = Get-Content -Path "C:\Comps.txt"
$output = @()
Foreach ($Computer in $Computers)
{
    $PstFiles = Get-Wmiobject -namespace "root\CIMV2" -computername $Computer -Query "Select * from CIM_DataFile Where Extension = 'pst'"
    foreach ($file in $PstFiles)
    {
        $pstinfo = "" | select Computer, Path, FileSize, LastModified, LastAccessed, Owner
        $filepath = $file.description
        $pstinfo.Computer = $file.PSComputerName
        $pstinfo.Path = $file.Name #Oddly the Name and Description contain the same data, full path to file
        $pstinfo.FileSize = $file.FileSize/1GB
        $pstinfo.Owner = (Get-ACL $file.Name).Owner
        $pstinfo.LastModified = [System.Management.ManagementDateTimeConverter]::ToDateTime($($file.LastModified))
        $pstinfo.LastAccessed = [System.Management.ManagementDateTimeConverter]::ToDateTime($($file.LastAccessed))
        $output += $pstinfo
    }
}
$output | Export-Csv c:\temp\ArchiveResults.csv -NoClobber -NoTypeInformation
