---
title: "SSL 101: What does an SSL do?"
subtitle:
date: 2016-05-09 17:16 +0000
tags: Security, Web Development, SSL, Design, Lean Startup
category: Cybersecurity
author_id: j_mcnally
image: https://s3.amazonaws.com/mediocre-production/uploads/image/filename/139/UIhero_lock.png
banner: true
featured: true
---

If you’ve ever done online banking or shopping, you’ve hopefully already taken advantage of an SSL connection. SSL stands for Secure Sockets Layer, and was developed as a mechanism for encrypting data as it flows from a user to a server, and vice versa.

![How SSL Encryption Works](https://s3.amazonaws.com/mediocre-production/uploads/image/filename/138/ssl.jpg)

This is hugely important because of the way the internet works. When your computer connects to, say, insert-your-bank-name-here.com, there’s not some piece of wire going from a bank's computer into your computer. Instead, we rely on a large network of routers and servers that essentially make up the internet or even “the cloud." When you type in yourbank.com, that address is first translated into a number, known as an IP. For this to work, your computer contacts a server that acts like dialing 411. Here is what is essentially happening at this point:

- You ask for a location 
- insert-your-bank-name-here.com and the operator sends back 131.123.323.543 
- Then it’s up to the first router (or hop) to send your request to a machine that it’s connected to (or to another router that might be connected to that machine)

To illustrate this, we can see what routers (hops) a request from my machine goes through before getting to my bank (kohactive.com): 

```bash
 1  Home: 10.1.10.1 (10.1.10.1)  3.365 ms  120.294 ms  1.575 ms
 2  Hop 1: 96.120.25.153 (96.120.25.153)  161.733 ms  65.522 ms  9.431 ms
 3  Hop 2: te-0-3-0-14-sur04.chicago302.il.chicago.comcast.net (162.151.33.61)  48.246 ms  166.636 ms  100.616 ms
 4  Hop 3:  te-1-2-0-4-ar01.area4.il.chicago.comcast.net (68.87.210.81)  195.722 ms
    te-2-9-0-6-ar01.area4.il.chicago.comcast.net (68.87.211.9)  12.326 ms  16.333 ms
 5  Hop 4:  be-33491-cr02.350ecermak.il.ibone.comcast.net (68.86.91.165)  138.855 ms  134.837 ms  17.822 ms
 6  Hop 5:  hu-0-10-0-7-pe01.350ecermak.il.ibone.comcast.net (68.86.89.174)  11.807 ms  129.791 ms  20.236 ms
 7  Hop 6: 50.248.119.42 (50.248.119.42)  11.296 ms  12.009 ms  11.812 ms
 8  Destination: 190.93.252.21 (190.93.252.21)  17.951 ms  12.727 ms  10.997 ms
```

In the example, there are 6 hops between my office router (10.1.10.1) and our website host (190.93.252.21).

With that out of the way, we can now visualize the real purpose or need for SSL. In the example above, any one of those 6 hops could have been hacked, or a malicious user could insert their network between our network and the web host's network, which would then give them the ability to monitor all of our traffic. Passwords, emails, credit card numbers, bank accounts, you name it. 

The internet was originally designed with a narrow scope for sharing research between government organizations and university labs, and it wasn't public. This naievity for what it would someday become led most service transmitting to occur in plain text. This is true for FTP (file transfer), email, and HTTP (web browsing).

When online shopping went mainstream, they needed a way to securely transmit data so that networks between you and a vendor couldn't read what was being transferred. This led to the widespread adoption of SSL.

So, what makes SSL secure? Encryption, for one, but it’s only as good as the person you’re trusting to show you how to encrypt your data. To remove the burden of having to give every user an encryption key, the private/public key system was devised. 

This means that every user shares a public key that can be encrypted, and the corresponding server has the only key that can decrypt that site’s traffic. This generally works pretty well because an attacker won’t have the public key to the private key that encrypted your credit card information before sending it to the website.

Now, you might ask, what prevents a malicious user from simply making their own private key and sending you their public key, decrypting the data, and passing it along to the website you thought you were talking to? 

The answer to this is essentially why SSL certificates, if you've ever looked into one before, cost money. In order to implement one, you’ll have to go through a trusted SSL vendor. These are reputable companies that comply with some baseline standard to ensure the certificates that they approve are only issued to the true owners of a website. This is enforced by browsers and software only accepting certificates issued by a preset list of vendors when the software is published. This means that you only get the green padlock in your browser if the site is using an SSL certificate issued by a company that checked that they were approving it for the true owner of that website.

Unfortunately, mistakes are made and people do steal private keys during data breaches, but on the whole, certificate revocations and similar responses have ensured that this is a fairly reliable way to secure the internet. 
