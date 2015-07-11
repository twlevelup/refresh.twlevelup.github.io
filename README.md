## Running locally

All changes should be made on the `source` branch. To preview the site locally(http://localhost:4000):

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

## Format of pages

Try to stick to an established standard. I think `location/event_type/event_number` seems to work well. Eg:

    /sydney/course/3.haml

or:

    /johannesburg/exp/1.haml

## Accessbility notes

These notes probably don't belong here, but I can't think of a better place for them to go right now :) - [@larenelg](https://github.com/larenelg)

Making your websites accessible to users with different disabilities. This includes but is not limited to vision-impaired users with screen readers, those with color vision deficiency, and keyboard-only users. [W3C WCAG](http://www.w3.org/WAI/intro/wcag) (Web Content Accessibility Guidelines) 2.0 outline a set of guidelines in order to meet different standards of web accessibility. The current standards have three levels of conformance (from lowest to highest): A, AA, and AAA. Government websites must meet WCAG 2.0 AAA standards (e.g. [usa.gov](http://www.usa.gov)), however it is nice if your website is able to meet A, if not AA standards.

**Images**

All images must have `alt` tags, if image is purely decorative use `alt=""` and screen reader will ignore the image.

If a section contains purely decorative html and/or images which would provide no value to a screen reader, it is safe to use the `aria-hidden="true"` attribute. This will indicate to the screen reader to ignore that section of the DOM.

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

**Known issues**

- ChromeVox doesn't currently read `<select>` dropdown boxes like native screen readers (it just ignores them when they are open). This is not the behaviour of native screen readers, which will read your selection as you navigate the dropdown options. It is not a problem with the code and does not need to be changed.
- Currently the pink text colour does not meet WCAG 2.0 contrast standards. This should be addressed using the WAVE toolbar sometime in the future.
