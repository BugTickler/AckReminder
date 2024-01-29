# Settings
$apiKey = "API_KEY"  # Opsgenie API Key
$teamId = "TEAM_ID"  # Team ID to monitor
$apiUrl = "https://api.opsgenie.com/v2/alerts?limit=100&query=teams=$teamId"  # Limit=100 and Team

# Function for retrieving alerts from Opsgenie
function Get-OpsgenieAlerts {
    $headers = @{
        "Authorization" = "GenieKey $apiKey"
    }

    $response = Invoke-RestMethod -Uri $apiUrl -Headers $headers -Method Get

    return $response.data
}

# Initialize variable to track sound playback for HOD alerts
$hodSoundPlayed = @{}
# Initialize variables to track priority changes
$previousPriority = @{}

# Infinite loop for checking every 10 seconds
while ($true) {
    # Retrieve and display open alerts without "ack" status
    $alerts = Get-OpsgenieAlerts
    $currentTime = Get-Date

    foreach ($alert in $alerts) {
        if ($alert.status -eq "open" -and $alert.acknowledged -ne "true") {
            $statusMessage = "Alert is open and Unacknowledged."

            Write-Host "------------------------"
            Write-Host "Alert ID: $($alert.id)"
            Write-Host "Source: $($alert.source)"
            Write-Host "Status: $($alert.status)"
            Write-Host "Created At: $($alert.createdAt)"
            Write-Host "Last Updated At: $($alert.updatedAt)"
            Write-Host $statusMessage
            Write-Host "------------------------"

            # Check if the "source" field contains "[HOD]"
            $isHodAlert = $alert.source -like "*[HOD]*"

            # Add warning if open for more than 2 minutes
            $timeDifference = $currentTime - [System.DateTime]$alert.updatedAt # TODO: Na odwrót XD
            if ($timeDifference.TotalMinutes -gt 2) {
                # Check if the priority has changed
                $previousPriority[$alert.id] = $previousPriority[$alert.id] -ne $alert.priority
                $priorityChanged = $previousPriority[$alert.id]

                # Playback sound
                if ($isHodAlert -and $timeDifference.TotalMinutes -gt 30 -and -not $hodSoundPlayed.ContainsKey($alert.id) -or $priorityChanged) {
                    Write-Host "Special condition met - playing sound after 30 minutes or priority change for alert with [HOD] in the source." -ForegroundColor Red
                    (New-Object Media.SoundPlayer "$PSScriptRoot\sound.wav").Play()

                    # Set flag for a specific alert to true
                    $hodSoundPlayed[$alert.id] = $true
                    $previousPriority[$alert.id] = $alert.priority
                } elseif (-not $isHodAlert) {
                    Write-Host "Normal condition - playing sound after 2 minutes for other alerts." -ForegroundColor Green
                    (New-Object Media.SoundPlayer "$PSScriptRoot\sound.wav").Play()
                }
            }
        }
    }

    # Wait for 10 seconds before checking again
    Start-Sleep -Seconds 10
}


