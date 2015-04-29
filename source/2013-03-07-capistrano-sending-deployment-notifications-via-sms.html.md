---
title: "Capistrano: Sending Deployment Notifications via SMS"
date: 2013-03-07 22:21 UTC
category: Programming
tags: capistrano, deployments, ruby
author_id: johnkoht
time_to_read: 3 min
background_color: "$brand-web-design"
---

When Gino first witnessed a deployment occurring in somebody's terminal window he was amazed by "the thing" that was happening. As a joke, we used to always notify him when we're "doing the thing". I decided to take our joke to another level and send text messages to him before and after each deployment, regardless of whether he's sitting across from me or not. 

It was incredibly easy to set up, so I figured I'd share, maybe somebody would use this for a real need. To get started, you'll need the following:

- [Capistrano](https://github.com/capistrano/capistrano)
- [Twilio SID, API Token and Phone Number](http://www.twilio.com/)
- [twilio-ruby gem](https://github.com/twilio/twilio-ruby)

I create a simple rake task that uses's Twlio's API to send the message. Twilio is fantastic and we've used it for a few years now for some awesome projects. Go register, it's free and you only pay for what you use. Once you've got an SID, API Token and Number, you can start using it.

Here's the rake task that will call the Twilio API and send the message.

```ruby
# Create a rake task that sends the message using Twilio. You'll 
# need a Twilio SID and Token as well as number
namespace :sms do
  desc "Send SMS message"
  task :send, [:message] => [:environment] do |t, args|    
    client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
    client.account.sms.messages.create(
      from: TWILIO_NUMBER,
      to: PHONE_NUMBER,
      body: args[:message]
    )
  end
end
```

And That's about it! No try deploying and you'll start getting text messages.

