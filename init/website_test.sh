#!/bin/bash

url='http://iac7.eastus.cloudapp.azure.com/'
code=`curl -sL --connect-timeout 20 --max-time 30 -w "%{http_code}\\n" "$url" -o /dev/null`

text="Infrastucture as code - Team 7"
name="Jenkins Build"

if [ "$code" = "200" ]; then
  color="65311"
  title="Website $url is online."
  description= "The website has been built and deployed without issues."
else
  color="15400960"
  title="Website $url is offline."
  description="Something went wrong, please check the logs the Jenkins webhook provided for troubleshooting."
fi

msg_content=\"$message\"

## discord webhook
url='https://discord.com/api/webhooks/910214380229124096/PVqCZVK7f1nRJP-OvG6Y85rIYqA-eoddsOWa5uJzdWLmuCoIzLtaT0a2_4lAOQRgVSAe'
curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": null, \"embeds\": [ { \"title\": \"$title\", \"description\": \"$description\", \"color\": \"$color\", 
\"author\": { \"name\": \"$name\" }, \"footer\": { \"text\": \"$text\" } } ] }" $url 