# kohactive blog
A repository that contains all blog posts that are deployed with kohactive.com

### Contributing
If you will be contributing regularly, it is recommended that you populate the .env file with the following environment variables:
```yaml
AUTHOR_NAME: Your Name
AUTHOR_EMAIL: example@email.com
AUTHOR_TWITTER: twitterhandle
AUTHOR_AVATAR: http://example.com/my/avatar.jpg
```
Once these variables are set, you can run:  
`middleman article "Title of Blog Post"`  
A markdown file will be generated in `/source` with your information at the top of the file.
