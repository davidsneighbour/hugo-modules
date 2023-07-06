# Developer Notes

## Firefox

It appears that the service worker needs to be manually started on local test installations in Firefox. Go to "More Tools" > "Web Developer Tools" > "Applications" > "Serviceworker" and start the service worker for testing.

## CORS requests (eg. Google Fonts)

In order to explicitly trigger a cors request, and get back a non-opaque response, you need to explicitly opt-in to CORS mode by adding the crossorigin attribute to your HTML:

```html
<link crossorigin="anonymous" rel="stylesheet" href="https://example.com/path/to/style.css">
<img crossorigin="anonymous" src="https://example.com/path/to/image.png">
```
