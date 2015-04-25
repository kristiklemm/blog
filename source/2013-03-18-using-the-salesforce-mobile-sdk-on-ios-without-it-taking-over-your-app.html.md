---
title: Using the Salesforce Mobile SDK on iOS without it taking over your app.
date: 2013-03-18 22:21 UTC
category: Programming
tags: iOS Development, xcode, Objective-C, SalesForce
author:
  name: Justin McNally
  email: justin@kohactive.com
  twitter: j_mcnally
  avatar: https://pbs.twimg.com/profile_images/570726681204117504/ltkFf5dq.jpeg
time_to_read: 13 min
image: http://cl.ly/ZhOj/Authorization.png
---

![SalesForce](http://cl.ly/ZhOj/Authorization.png)

We've been working on a project for a client with the requirement of integrating this application with Salesforce. Unlike many of the applications being developing on top of the salesforce platform, the application we are developing is split into two parts. One half is an entire catalog of product offerings, complete with spec sheets, pdfs and videos. This half runs on kohCMS, a powerful content management system for websites and mobile applications. The second half of the application allows sales reps to use this catalog to generate quotes in their salesforce organization. Unfortunately Salesforce's new ios-sdk expects Salesforce authentication to be at the forefront of the application, but in our case the Salesforce implementation is more of an augmentation. This presented a few challenges in how the SDK expects everything to work.

One of the primary challenges in working with the SDK was that it expects to be the AppDelegate. In our case this just isn't possible not only does the client have its own authorization layer that consumes the AppDelegate we only want to require authorization when the user is trying to use one of the salesforce enabled features, primarily creating a new quote. 

So how do we use the SDK without making it our app delegate and making the entire application dependent on it. We'll in my approach I tore out everything the AppDelegate does, and do it myself in a plain old UIViewController

First Create a new UIViewController

```objectivec
//SFDCLoginViewController.h
#import "SFOAuthCoordinator.h"
@interface SFDCLoginViewController : UIViewController <SFOAuthCoordinatorDelegate, UIAlertViewDelegate>  { 
  SFOAuthCoordinator *_coordinator;
}
@end
```

The header file says we are going to implement the SFOAuthCoordinatorDelegate which handles the OAuth callbacks from SFDC and we define an Auth coordinator. 

Next is the .m file or implementation of the view controller

I am using a storyboard in my example so my viewcontroller calls +[initWithCoder]

```objectivec
- (id) initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self doInit];
  }
  return self;
}

- (void) doInit
{
  [SFAccountManager setLoginHost:[self oauthLoginDomain]];
  [SFAccountManager setClientId:[self remoteAccessConsumerKey]];
  [SFAccountManager setRedirectUri:[self oauthRedirectURI]];
  [SFAccountManager setCurrentAccountIdentifier:[self userAccountIdentifier]];
}
```

This basically does the same work Salesforce's app delegate does. Setting up the new SFAccountManager the methods below also come from the appdelegate which informs the app what the endpoints are etc.

```objectivec
- (NSString*)remoteAccessConsumerKey {
  return OAuthConsumerKey;
}

- (NSString*)oauthRedirectURI {
  return @"appname://mobilesdk/detect/oauth/done";
}

-(NSString *)oauthLoginDomain {
  return OAuthLoginDomain;
}

-(NSString *) userAccountIdentifier {
  return @"user";
}

-(void) oauthCoordinator:(SFOAuthCoordinator *)coordinator didBeginAuthenticationWithView:(UIWebView *)view {
  [[self view] addSubview:view];
  [view setFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT)];
}

- (SFOAuthCoordinator*)coordinator {
    //create a new coordinator if we don't already have one
  if (nil == _coordinator) {
    
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    NSString *loginDomain = [self oauthLoginDomain];
    NSString *accountIdentifier = [self userAccountIdentifier];
      //here we use the login domain as part of the identifier
      //to distinguish between eg  sandbox and production credentials
    NSString *fullKeychainIdentifier = [NSString stringWithFormat:@"%@-%@-%@",appName,accountIdentifier,loginDomain];
    
    
    SFOAuthCredentials *creds = [[SFOAuthCredentials alloc]
                                 initWithIdentifier:fullKeychainIdentifier
                                 clientId: [self remoteAccessConsumerKey] encrypted:NO ];
    
    
    creds.domain = loginDomain;
    creds.redirectUri = [self oauthRedirectURI];
    
    SFOAuthCoordinator *coord = [[SFOAuthCoordinator alloc] initWithCredentials:creds];
    coord.scopes = [NSSet setWithObjects:@"web",@"api",nil];
    coord.delegate = self;
    _coordinator = coord;
  }
  
  return _coordinator;
}
```

Finally we just need to implement our handler for after a successful authentication. It sets the API's coordinator and the account managers credentials which should wire-up everything you need to start making requests.

```objectivec
- (void)oauthCoordinatorDidAuthenticate:(SFOAuthCoordinator *)coordinator {
  [coordinator.view removeFromSuperview];
  [[SFRestAPI sharedInstance] setCoordinator:coordinator];
  [SFAccountManager sharedInstance].credentials = coordinator.credentials;
  
  //pop the view or remove the modal. Your SFRestAPI is now ready to use.  
}
```

You can test your connection with a simple query like this:

```objectivec
  [[SFRestAPI sharedInstance] performSOQLQuery:@"SELECT id FROM Account" failBlock:^(NSError *e) {
    
  } completeBlock:^(NSDictionary *dict) {
    NSLog(@"%@", dict);
  }];
```