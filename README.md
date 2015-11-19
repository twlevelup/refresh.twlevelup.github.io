## Running locally

All changes should be made on the `source` branch. To preview the site [locally](http://localhost:4000):

    $ bundle install && bundle exec jekyll serve -w --baseurl=""


## Building

    $ bundle exec rake generate

## Deploying

**There is no staging. Please make sure that things work locally before
deploying.**

    $ bundle exec rake publish

Brief technical notes: since we use custom plugins (haml, sass, etc) which
GitHub pages doesn't support our deployment is a bit odd. `rake publish` first
generates the site and then obliterates the existing origin/master replacing it
with the generated code by `push --force`'ing.

## Registering events
The site makes use of markdown, front matter and templates to better standardise content, and to make updating events easier - ie. no writing html.

### Key resources 

_data\cities.yml 

List of cities which host events. 

Add any new cities and types of events in the cities here. 
You can set the default description for these events (specific to a city).  

_layouts\

Contains all of the layouts in use for the site. 

Most of the the yml front-matter you assign in your content page will be used to populate the relevant layout. At the moment events use the event.html layout, but different ones can be added as needed. You just need to handle the front-matter in the layout.

### Creating a new event
**if the event type is new, or the city is new you'll need to update the cities.yml file first (see above)**

- In the path for the city and event type create a new .md file . eg. `/sydney/course/3.md`

Try to stick to the established standard: `location/event_type/event_number` as it becomes the route

- Write the content.
For the "event" template this will populate into the "course information" section of the "event" template

- Set the yml front matter at the top of the markdown file. This will be used to populate the templates.

The active flag should be set to false for finished events

Registration can be set to one of three states: open, pending, closed. This will update the registration option on the site. 

** Example below ** 
```html
---
layout: event
active: true
type: course
city: Melbourne
event: LevelUp Build
title:
date: !!timestamp 2015-08-29
location:
  description: ThoughtWorks Melbourne<br /> Level 23, 303 Collins Street Melbourne, VIC 3000
  url: https://www.google.com.au/maps/place/ThoughtWorks/@-37.816684,144.963962,17z/data=!3m1!4b1!4m2!3m1!1s0x6ad642b48bb52925:0xbdc7c2910979075a
registration:
  state: open
  url: http://goo.gl/forms/RpoNtpwoZp
key-dates:
  - name: Info Night
    value: Tue 11 Aug 2015, 6:30pm - 7:30pm
  - name: Kick Off
    value: Sat 29 Aug 2015, 9am - 5pm
  - name: Duration
    value: 7 Weeks
  - name: Regular Classes
    value: Every Tuesday starting Tue 01 Sep 2015, 6pm - 9pm
  - name: Final Showcase
    value: Sat 17 Oct 2015
---
```

Final note. Jekyll will generate and publish a static site. Unless you want to play with js (and feel free to), things like updating registration state require the site to be republished. 

## Accessbility notes

_These notes probably don't belong here, but I have no where else to put them :) - [@larenelg](https://github.com/larenelg)_

Making a website accessible to users with different disabilities. This includes, but is not limited to, vision-impaired users with screen readers, those with color vision deficiency, and keyboard-only users. [W3C WCAG](http://www.w3.org/WAI/intro/wcag) (Web Content Accessibility Guidelines) 2.0 outline a set of guidelines in order to meet different standards of web accessibility. The current standards have three levels of conformance (from lowest to highest): A, AA, and AAA. Government websites must meet WCAG 2.0 AAA standards (e.g. [usa.gov](http://www.usa.gov)). It is nice if your website is able to meet A, if not AA standards.

**Images**

All images must have `alt` tags, if image is purely decorative use `alt=""` and screen reader will ignore the image.

If a section contains purely decorative HTML and/or images which would provide no useful information to a screen reader, it is safe to use the `aria-hidden="true"` attribute. This will indicate to the screen reader to ignore that section of the DOM.

**Elements in the DOM**

Try, as much as possible, to use HTML5 native elements for better screen reader and keyboard-only support, for example:
	
	`<a>` and `<button>` elements have different native behaviour for keyboard-only users, you would have to add jquery to get an `<a>` element to respond to keyboard shortcuts in the same way as a `<button>` element - e.g. pressing a spacebar. A screen reader will identify `<a>` elements by speaking `link` and `<button>` by speaking `button`.

The order of elements in the DOM is also important, the screenreader only sees the DOM (or the HTML code) and reads through it in that order. Try as much as possible to keep the information in a logical order in the code, and change the location and appearance of items using CSS.

**Skip links**

Skip links are for keyboard only users to quickly navigate past headers/navigation. Users also return to them if they get lost on the page, so they need to be the first tabbable element in the DOM (the first item in the `<body>`)

```html
<a class="skip-link" href="#content"> Skip to Main Content </a>
```

**Aria Labels**

Ideally, when adding forms a the website, to make sure an input box is appropriately labelled so that screenreaders can read out what inputs - this can be done using the `<label>` element, e.g. 
	
```html
<form action="demo_form.asp">
    <label for="male">Male</label>
    <input type="radio" name="sex" id="male" value="male"><br>
    <label for="female">Female</label>
    <input type="radio" name="sex" id="female" value="female"><br>
    <input type="submit" value="Submit">
</form>
```

If you do not feel like having a text label, you can supply a label using the `aria-label` attribute directly inside the `<input>` element. For example

```html
<button aria-label="Close" onclick="myDialog.close()">X</button>
```

In other situations, it is appropriate to use `aria-labelledby` and `aria-describedby`, e.g.

```html
<button aria-label="Close" aria-describedby="descriptionClose" onclick="myDialog.close()">X</button>

...

<div id="descriptionClose">Closing this window will discard any information entered and return you back to the main page</div>
```

**Tools**

- Quickly learn accessibility basics from [this great tutorial](https://webaccessibility.withgoogle.com/course)
- [ChromeVox](http://www.chromevox.com/) - a Chrome extension screen reader, great for simulating how a screen reader will narrate your website. There are many keyboard shortcuts to learn before you can effectively use a screen reader, it's good to do a tutorial or two. Popular screen readers include VoiceOver (Mac) and [NVDA](http://www.nvaccess.org/) (Win).
- [Wave toolbar](https://wave.webaim.org/toolbar/) - a browser extension that visually identifies possible accessibility issues with any site (including localhost).

**Known accessibility issues**

- ChromeVox doesn't currently read `<select>` dropdown boxes like native screen readers (it just ignores them when they are open). This is not the behaviour of native screen readers, which will read your selection as you navigate the dropdown options. It is not a problem with the code and does not need to be changed.
- Currently the pink text colour does not meet WCAG 2.0 contrast standards. This should be addressed using the WAVE toolbar sometime in the future.
