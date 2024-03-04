function Insert {
    $query = "SELECT * FROM __InstanceCreationEvent WITHIN 5 WHERE TargetInstance ISA 'Win32_PnPEntity' AND TargetInstance.Description LIKE '%FIDO%'"
    $action = {
        #Write-Host "Inserted FIDO device."
        $tempFile = Join-Path -Path $env:TEMP -ChildPath "t2.trigger.txt"
        Set-Content -Path $tempFile -Value "Inserted"
    }
    Unregister-Event -SourceIdentifier "PnPInserted" -ErrorAction SilentlyContinue
    Register-WmiEvent -Query $query -Action $action -SourceIdentifier "PnPInserted" | Out-Null
}

function Delete {
    $query = "SELECT * FROM __InstanceDeletionEvent WITHIN 5 WHERE TargetInstance ISA 'Win32_PnPEntity' AND TargetInstance.Description LIKE '%FIDO%'"
    $action = {
        #Write-Host "Deleted FIDO device."
        $tempFile = Join-Path -Path $env:TEMP -ChildPath "t2.trigger.txt"
        Set-Content -Path $tempFile -Value "Deleted"
    }
    Unregister-Event -SourceIdentifier "PnPDeleted" -ErrorAction SilentlyContinue
    Register-WmiEvent -Query $query -Action $action -SourceIdentifier "PnPDeleted" | Out-Null
}

function MonitorFIDO2 {
    while ($true) {
        $tempFile = Join-Path -Path $env:TEMP -ChildPath "t2.trigger.txt"
        if (Test-Path $tempFile) {
            $content = Get-Content -Path $tempFile
            if ($content -eq "Deleted") {
                #Write-Host "Locking workstation..."
                Start-Process -FilePath "powershell.exe" -ArgumentList "rundll32.exe user32.dll,LockWorkStation"
                Remove-Item -Path $tempFile -Force
            }
        }
        Start-Sleep -Seconds 1
    }
}

# Start the functions


# Loop indefinitely to keep the script running
while ($true) {
	Insert
	Delete
    MonitorFIDO2
    Start-Sleep -Seconds 1  # Adjust sleep time as needed
}
