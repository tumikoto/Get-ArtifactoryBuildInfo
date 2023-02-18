#
# Script to get buildInfo from all builds we have access to from an Artifactory server using REST API username + key
#

# Server
$serverBaseUri = "https://artifacts.example.com/artifactory"

# Setting up auth headers
$b64 = "Your <user>:<api-key> in base64 or encypted token goes here"
$headers = @{Authorization="Basic " + $b64}

# Getting all builds
Write-Host [+] Getting all builds we have access to
$buildsResponse = Invoke-RestMethod -Method GET -Headers $headers -Uri ($serverBaseUri + "/api/builds")

# Loop through all builds
foreach ($build in $buildsResponse.data)
{
	# Get build info for current build
	Write-Host [+] Getting build details for ($build).buildName/($build).buildNumber
	$buildnumResponse = Invoke-RestMethod -Method GET -Headers $headers -Uri ($serverBaseUri + "/api/build/" + $build.buildName + "/" + $build.buildNumber)
	
	# Write buildInfo to console (if any)
	$buildnumResponse.BuildInfo.properties
}

# Done
Write-Host [+] Done!
