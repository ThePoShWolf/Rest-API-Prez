# Rest API Presentation

## cURL vs Invoke-RestMethod

This is for an Airtable API call to retrieve info from a base called: 'appBLvHFF78kERCvW' and the 'Payees' Table:

[source](https://airtable.com/api)
```bash
$ curl https://api.airtable.com/v0/appBLvHFF78kERCvW/Payees \
-H "Authorization: Bearer YOUR_API_KEY"
```

```PowerShell
Invoke-RestMethod -Uri https://api.airtable.com/v0/appBLvHFF78kERCvW/Payees -Header @{
    Authorization = "Bearer YOUR_API_KEY"
}
```

That -H is header stuff:

### Retrieving templates from the PDF Generator API:

[source](https://pdfgeneratorapi.com/docs#templates-get-all)
```bash
curl -H "X-Auth-Key: 61e5f04ca1794253ed17e6bb986c1702" \
    -H "X-Auth-Workspace: demo.example@actualreports.com" \
    -H "X-Auth-Signature: " \
    -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    -X GET https://us1.pdfgeneratorapi.com/api/v3/templates
```

```PowerShell
Invoke-RestMethod -Uri 'https://us1.pdfgeneratorapi.com/api/v3/templates' -Header @{
    'X-Auth-Key' = '61e5f04ca1794253ed17e6bb986c1702'
    'X-Auth-Secret' = '68db1902ad1bb26d34b3f597488b9b28'
    'X-Auth-Workspace' = 'demo.example@actualreports.com'
    'Content-Type' = 'application/json'
    'Accept' = 'application/json'
}
```

### Using parameters with basic authentication

[source](https://documenter.getpostman.com/view/4454237/apisherpadeskcom-playground/RW8AooQg#6a1f8cfa-8910-8c9f-2e68-bfaefb51920b)
```bash
curl --request GET "https://ncg1in-8d1rag:5nuauzj5pkfftlz3fmyksmyhat6j35kf@api.sherpadesk.com/tickets?status=open,onhold&role=user&limit=6&format=json" \
  --data ""
```

```PowerShell
# Convert to Base64 (watch encoding!)
$encodedAuth = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes('ncg1in-8d1rag:5nuauzj5pkfftlz3fmyksmyhat6j35kf'))
$header = @{
    Authorization = "Basic $encodedAuth"
    Accept = 'application/json'
}
Invoke-RestMethod -Uri 'https://api.sherpadesk.com/tickets?status=open,onhold&role=user&limit=6&format=json' -Headers $header
```

# Standardizing API calls with an Invoke-APICall cmdlet

# Managing API credentials.