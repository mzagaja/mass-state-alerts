# Mass State Alert aka BakerBot

This app posts an alert to a slack channel of your choosing if the Governor of Massachusetts declares an alert. To get this to work with your slack installation you need to setup a new [incoming webhook](https://api.slack.com/incoming-webhooks) and then set your SLACK_WEBHOOK_URL environment variable to that. The alert is triggered by running the rake task `rake alerts:check`. It will remember whether it perviously alerted and keep a log of alerts. Ideally you should use a scheduler to poll the website at a sane interval.
