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