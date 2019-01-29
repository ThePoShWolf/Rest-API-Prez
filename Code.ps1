#region cURL vs Invoke-RestMethod

# Airtable GET example
Invoke-RestMethod -Uri https://api.airtable.com/v0/appBLvHFF78kERCvW/Payees -Headers @{
    Authorization = "Bearer $AirTableKey"
}

# PDF Generator GET Example
$header = @{
    'X-Auth-Key' = $PDF.key
    'X-Auth-Secret' = $PDF.secret
    'X-Auth-Workspace' = $PDF.workspace
    'Content-Type' = 'application/json'
    'Accept' = 'application/json'
}
Invoke-RestMethod -Uri 'https://us1.pdfgeneratorapi.com/api/v3/templates' -Headers $header

# SherpaDesk GET example:
$encodedAuth = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("$key`-$inst`:$apikey"))
$header = @{
    Authorization = "Basic $encodedAuth"
    Accept = 'application/json'
}
Invoke-RestMethod -Uri 'https://api.sherpadesk.com/tickets?status=open,onhold&role=user&limit=6&format=json' -Headers $header

# Airtable POST example
$headers = @{
    Authorization = "Bearer $AirTableKey"
    'Content-Type' = 'application/json'
    Accept = 'application/json'
}
$body = @{
    fields = @{
        Name = 'EWEB'
        Notes = 'Water and electric'
        Expenses = @(
            "reccvn4TB4twTQDrs"
        )
    }
} | ConvertTo-Json
Invoke-WebRequest -Uri 'https://api.airtable.com/v0/appBLvHFF78kERCvW/Payees' -Method Post -Headers $headers -Body $body