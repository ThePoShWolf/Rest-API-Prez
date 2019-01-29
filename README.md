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

#### SherpaDesk PUT

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

## Leave it to the user

This is unwieldy and a bad idea. Makes for commands like these:

```PowerShell
Get-SDTicket -Organization 'ncg1in' -Instance '8d1rag' -Key '5nuauzj5pkfftlz3fmyksmyhat6j35kf'
# Or
Get-Record -BaseIdentity 'Finances' -Table 'Payees' -ApiKey 'keyttau093ptSHauP'
```

And sure, you could just:

```PowerShell
$PSDefaultParameterValues = @{
    '*-SD*:Organization' = 'ncg1in'
    '*-SD*:Instance' = '8d1rag'
    '*-SD*:Key' = '5nuauzj5pkfftlz3fmyksmyhat6j35kf'
}
Get-SDTicket
```

Where's the fun in that?

## Module (script) scoped variable

Inside your .psm1:
```PowerShell
$script:ApiKey = 'key'
```

But you have to have it to be able to set it...

### SherpaDesk Example

[Repo](https://github.com/theposhwolf/pssherpadesk)

Retrieve the API key from the API using a user's email and password:

```PowerShell
$credential = Get-Credential
$up = "$($credential.GetNetworkCredential().UserName)`:$($credential.GetNetworkCredential().Password)"
$encodedUP = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("$up"))
$header = @{
        Authorization = "Basic $encodedUP"
        Accept = 'application/json'
    }
$resp = Invoke-RestMethod -Method Get -Uri 'https://api.sherpadesk.com/login' -Headers $header
$Script:AuthConfig = @{
    ApiKey = $resp.api_token
    WorkingOrganization = ''
    WorkingInstance = ''
}
```

This is soooo convenient. This turns into:

```PowerShell
Get-SDApiKey -Email email@domain.com
```

Though as you saw with earlier API examples, you still need your Org and Instance, but there is a call for that:

```PowerShell
$encodedAuth = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("x:$ApiKey"))
$header = @{
    Authorization = "Basic $encodedAuth"
    Accept = 'application/json'
}
$resp = Invoke-RestMethod -Uri 'https://api.sherpadesk.com/organizations/' -Method Get -Headers $header
$Script:AuthConfig.WorkingOrganization = $resp[0].key
$Script:AuthConfig.WorkingInstance = $resp[0].instances[0].key
```

And now you have a module scope variable to use in your parameter blocks like:

```PowerShell
Function Get-SDTicket{
    [cmdletbinding()]
    Param(
        [parameter(
            ParameterSetName = 'ByKey'
        )]
        [string]$Key,
        [string]$Organization = $authConfig.WorkingOrganization,
        [string]$Instance = $authConfig.WorkingInstance,
        [string]$ApiKey = $authConfig.ApiKey
    )
...
}
```

### PDF Generator API example

[Repo](https://github.com/theposhwolf/PS_PDFGeneratorAPI)

For this API, and most, you have to download some auth info ahead of time. But you can still save it:

```PowerShell
Function New-PDFGenAuthConfig {
    Param (
        [ValidateNotNullOrEmpty()]
        [string]$key,
        [ValidateNotNullOrEmpty()]
        [string]$secret,
        [ValidateNotNullOrEmpty()]
        [string]$workspace
    )
    $Script:AuthConfig = [pscustomobject] @{
        key = $key
        secret = $secret
        workspace = $workspace
    }
}
```

And of course, use these in your parameter blocks:

```PowerShell
Function Get-PDFGenTemplates {
    Param(
        [ValidateNotNullOrEmpty()]
        [string]$key = $AuthConfig.key,
        [ValidateNotNullOrEmpty()]
        [string]$secret = $AuthConfig.secret,
        [ValidateNotNullOrEmpty()]
        [string]$workspace = $AuthConfig.workspace
    )
...
}
```

## Store locally?

Should you store your API keys in clear text?

![No](https://i.imgur.com/DKUR9Tk.png)

### But you can encrypt them using PowerShell!

[repo](https://github.com/techsnips/psairtable)

Credit to Adam Bertram

He encrypts the API key using ConvertTo-SecureString:

```PowerShell
function Save-AirTableApiKey {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$ApiKey
    )

    function encrypt([string]$TextToEncrypt) {
        $secure = ConvertTo-SecureString $TextToEncrypt -AsPlainText -Force
        $encrypted = $secure | ConvertFrom-SecureString
        return $encrypted
    }
    $config = Get-PSAirTableConfiguration
    $config.Application.ApiKey = encrypt($ApiKey)
    $config | ConvertTo-Json | Set-Content -Path "$WorkingDir\Configuration.json"
}
```

I can't speak to the security of said secure string, but it _might_ be considered good enough for _most_ use cases.