# Rest API Presentation

## cURL vs Invoke-RestMethod

### Getting Data

#### Getting records from Airtable

Retrieves info from a base called: 'appBLvHFF78kERCvW' and the 'Payees' Table:

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

#### Retrieving templates from the PDF Generator API:

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

#### Using Parameters, Basic Authentication

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

### Creating or Updating Data

PATCH Updates
POST Creates
PUT Replaces

#### Airtable API PATCH

Note the resource uri.

```bash
curl -v -XPATCH https://api.airtable.com/v0/appBLvHFF78kERCvW/Payees/recMvdJuoL6ivDA9I \
-H "Authorization: Bearer YOUR_API_KEY" \
-H "Content-Type: application/json" \
 -d '{
  "fields": {
    "Name": "Eugene Water and Electric Board"
  }
}'
```

```PowerShell
$headers = @{
    Authorization = "Bearer YOUR_API_KEY"
    'Content-Type' = 'application/json'
}
$body = @{
    fields = @{
        Name = 'Eugene Water and Electric Board'
    }
} | ConvertTo-Json
Invoke-WebRequest 'https://api.airtable.com/v0/appBLvHFF78kERCvW/Payees/recMvdJuoL6ivDA9I' -Method Patch -Headers $headers -Body $body
```

#### PDF Generator API POST

```bash
curl -H "X-Auth-Key: 61e5f04ca1794253ed17e6bb986c1702" \
    -H "X-Auth-Workspace: demo.example@actualreports.com" \
    -H "X-Auth-Signature: 423e1a765bb24d5139a7258545066d3fcb310998044ea3c000e393b75f5167d6" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    -X POST -d '{"id":304355781,"name":"#1014A","number":15,"note":"Customer Notes","shipping_address":{"name":"John Smith","address":"St Patrick Road 4","city":"London","country":"United Kingdom","zip":"UK12991"}}' \
    'https://us1.pdfgeneratorapi.com/api/v3/templates/21661/output?format=pdf&output=base64'
```

```PowerShell
$header = @{
    "X-Auth-Key" =" 61e5f04ca1794253ed17e6bb986c1702"
    "X-Auth-Workspace" = "demo.example@actualreports.com"
    "X-Auth-Signature" = "423e1a765bb24d5139a7258545066d3fcb310998044ea3c000e393b75f5167d6"
    "Content-Type" = "application/json"
    "Accept" = "application/json"
}
$body = @{
   id = 304355781
   name = "#1014A"
   number = 15
   note = "Customer Notes"
   shipping_address = @{  
      name = "John Smith"
      address = "St Patrick Road 4"
      city = "London"
      country = "United Kingdom"
      zip = "UK12991"
   }
} | ConvertTo-Json
Invoke-RestMethod -Uri 'https://us1.pdfgeneratorapi.com/api/v3/templates/21661/output?format=pdf&output=base64' -Method Post -Headers $header -Body $Body
```

#### SherpaDesk POST

```bash
curl --location --request PUT "https://ncg1in-8d1rag:5nuauzj5pkfftlz3fmyksmyhat6j35kf@api.sherpadesk.com/time/{{time_id}}?format=json" \
  --form "account_id=-1" \
  --form "hours=0.25" \
  --form "is_project_log=true" \
  --form "note_text=test_30/01_31/01" \
  --form "task_type_id={{task_type_id}}" \
  --form "tech_id={{user_id}}"
```

```PowerShell
$encodedAuth = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes('ncg1in-8d1rag:5nuauzj5pkfftlz3fmyksmyhat6j35kf'))
$header = @{
    Authorization = "Basic $encodedAuth"
    Accept = 'application/json'
    'Content-Type' = 'application/json'
}
$body = @{
    account_id = '-1'
    hours = '0.25'
    is_project_log = 'true'
    note_text = 'test_30/01_31/01'
    task_type_id = '{{task_type_id}}'
    tech_id ='{{user_id}}'
} | ConvertTo-Json
Invoke-RestMethod -Uri "https://api.sherpadesk.com/time/{{time_id}}?format=json" -Method Put -Headers $header -Body $body
```

# Standardizing API calls with an Invoke-APICall cmdlet

# Managing API credentials.