---
title: Proxy APIs To Avoid Same-Origin Issues
date: 2013-04-16 22:21 UTC
category: DevOps
tags: Ember, Nginx, DevOps
author:
  name: Justin McNally
  email: justin@kohactive.com
  twitter: j_mcnally
  avatar: https://pbs.twimg.com/profile_images/570726681204117504/ltkFf5dq.jpeg
time_to_read: 6 min
image: http://cl.ly/ZiRR/operator.jpg
background_color: "$brand-web-engineering"
---

![Proxy APIs](http://cl.ly/ZiRR/operator.jpg)

Recently we were hired to build a desktop HTML5 version of a client's existing iphone offering. First we evaluated platforms for development. The app already had an API in place for use with the iphone application so we settled on just building another client, in the browser. We didn't see the need to develop in ruby and create a second bottle neck with our own server side application that would act as nothing more than a "smart" proxy for the api. After some quick white boarding we decided to build the application with EmberJS and manage the project with middleman. I'll save those details for another post, the important thing is that to understand in this scenario is that the API is hosted by google app engine, and our web client is not. The problem, for those who don't already know, is that thanks to things like Cross-Site Scripting attacks and other malicious browser based DDoS most major browser vendors have locked down the ability to make ajax calls between domains. This leaves developers 3 options when they need far and distant data.

1. JSON-P, a psuedo-standard which allows GET requests to happen between clients and properly configured servers through the use of script tag hacks. The flow here is to define a callback somewhere in code

```javascript
var jsonp_callback = function(data) {
    //do something with the data from the server
    console.log(data)
}
```

Given the previous code block we make our jsonp request which is transformed to the following

```html
<script src="http://www.api.com/getrequestendpoint?foo=bar&callback=jsonp_callback"></script>
```

The server side would the construct a json response wrapped in the passed callback

```javascript
jsonp_callback({var: data, foo: bar})
```

Now since this was loaded via a script tag proxy that code is immediately executed. The net-result is that the json data is passed to our defined callback function, and we can easily use the data in our callback. In modern javascript libraries these gymnastics are completely abstracted and are implemented by users exactly like a normal ajax request.

2) CORS/Options Preflighting, this option is not really a proxy and must also be implemented by the endpoint server, so you need to have control of the API in order to leverage it. Basically this is implemented by responding to OPTIONS requests and responding with headers that define what domains and data are allowed from 3rd party clients and external domains. This is a bit out of the scope of this post, but you can see a complete write up by mozilla on https://developer.mozilla.org/en-US/docs/HTTP/Access_control_CORS.

3) NGINX/Reverse Proxy, this option will allow you to mount a api as a relative path on your domain, if you are familiar with NGINX or mod_proxy this is just like mounting another web deamon such as PHP-FPM, thin or unicorn. 

First we start with an upstream block:

```nginx
upstream ssl_api {
  server something.appspot.com:443;
}
```

This basically defines the base of our foreign api and it's port.
From there we can define a location in our server block and mount the upstream.

```nginx
location /api {
  proxy_set_header X-Real-IP $remote_addr;
  proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  proxy_set_header Host something.appspot.com;
  proxy_set_header X-NginX-Proxy true;
  proxy_pass https://ssl_api/;
  proxy_ssl_session_reuse off;
  proxy_redirect off;
}
```
For some reason google app engine won't let use reuse ssl sessions so its very important to turn that off if you are experiencing conditions where the request works once and then fails until the server is restarted. Also, if you are using a shared environment like appengine or heroku you will need to re-write the Host header to your exact hostname so that their server knows which app you are looking for, otherwise nginx will pass your local domain which unless configured the 3rd party service will not know how to serve.

In our project we chose the 3rd, nginx, option because it was fast, easy to setup, and required no additional changes to the already established api that was being used for the iphone. It gave us the flexibility to have paths for our client application to be located on the same domain as our api and required no backend language. If you have any questions or input feel free to reach out to us via the comments below.