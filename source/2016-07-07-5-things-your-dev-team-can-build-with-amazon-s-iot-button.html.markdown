---
title: 5 Things Your Dev Team Can Build with Amazon's IoT Button
subtitle: It’s not just for cat litter anymore.
date: 2016-07-07 13:30 +0000
tags: IoT, Design
category: Culture
author_id: lrdiv
image: http://www.iotnewsnetwork.com/wp-content/uploads/2016/01/HiRes1-720x375.jpg
banner: true
featured: true
---

Amazon recently announced the launch of a limited release programmable Dash Button. Existing Amazon Dash buttons can help you order things like toilet paper, razor blades, or cat food with the press of a button. The new programmable buttons present many possibilities, especially when paired with other IoT hardware like light bulbs.

Here are 5 uses for the Amazon IoT button that could enhance company productivity or culture:

### 1. A sound machine

At kohactive, <a href="https://github.com/lrdiv/slash-sound" target="_blank">our "sound machine" is powered by Slack</a>, but the goal was to have something like a rimshot button for bad jokes, or a sad trombone button for spilt coffee. Similarly, we can now use a single Amazon button for rimshots, sad trombones, and hadoukens (the celebratory cry of kohactivators). The Dash button sends a "clickType" parameter which can be single, double, or a long-press, which then enables your sound machine to play different files based on how the button is pushed.

### 2. A brighter conference room

Right when a client walks in the door you can remotely turn on the smart bulbs in your conference room to create a welcoming feel. Need to cut the lights for dramatic effect during a presentation? Configure the IoT button to turn the lights off with a double press.

**Bonus idea**: Use a smart outlet to fire up the projector along with the lights.

### 3. A "Do Not Disturb" indicator

Say goodbye to interruptions when you set up a red LED that warns people you're in the zone. Better yet, toggle between red, yellow, and green to let people know your availability. Lumbergh won't head straight for your desk for those TPS reports at 4:52pm on a Friday if he can see that you're dialed in.

The Pi Hut has <a href=
"https://thepihut.com/blogs/raspberry-pi-tutorials/27968772-turning-on-an-led-with-your-raspberry-pis-gpio-pins" target="_blank">a great tutorial on hooking an LED light up to your Raspberry Pi</a>.

### 4. A Slack bot

If you have some phrases you find yourself using often on Slack, try these out:

*Single press:* "I'm heading out for the day. See everyone tomorrow! :simple_smile:"

*Double press:* "I'm working from home today :house_with_garden: see you all at standup."

*Long press:* "Did anybody make :coffee: yet?"

These can obviously be customized. Check out Slack's "Introduction to Messages" documentation to learn how to build the back-end of this service.

### 5. An Uber button

If the team is ready for lunch or an outing, don't make them wait while you get your phone out to summon an Uber. Just hardcode the office address in the function that hits <a href="https://developer.uber.com/docs/rides/tutorials-rides-api" target="_blank">Uber’s request API</a>. You can even get creative and change the type of car you’re requesting with different button presses.

![IoT Button](http://i.imgur.com/4l8JnBa.png)

*Image from <a href="http://www.iotnewsnetwork.com/magazine/three-trends-that-will-bring-the-internet-of-things-to-the-forefront/" target="_blank">IoT News Network</a>*