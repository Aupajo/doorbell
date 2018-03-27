# Doorbell

Use Twilio to unlock a door buzzer using DTMF tones.

## Developing

Requires Ruby 2.1+ and [Bundler](http://bundler.io/).

Install dependencies:

    bundle install

Start a local server:

    PASSCODE=1234 bundle exec shotgun

## Deploying

To Heroku:

    heroku create
    heroku config:set PASSCODE=1234
    git push heroku master

## Configuring Twilio

Add a new Programmable Voice phone number.

Set the “A Call Comes In” Webhook to the URL.
