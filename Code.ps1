#region cURL vs 

# Airtable example
Invoke-RestMethod -Uri https://api.airtable.com/v0/appBLvHFF78kERCvW/Payees -Header @{
    Authorization = "Bearer $AirTableKey"
}

#PDF Generator Example
Invoke-RestMethod -Uri 'https://us1.pdfgeneratorapi.com/api/v3/templates' -Header @{
    'X-Auth-Key' = $PDF.key
    'X-Auth-Secret' = $PDF.secret
    'X-Auth-Workspace' = $PDF.workspace
    'Content-Type' = 'application/json'
    'Accept' = 'application/json'
}

#SherpaDesk example:
$encodedAuth = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("$key`-$inst`:$apikey"))
$header = @{
    Authorization = "Basic $encodedAuth"
    Accept = 'application/json'
}
Invoke-RestMethod -Uri 'https://api.sherpadesk.com/tickets?status=open,onhold&role=user&limit=6&format=json' -Headers $header