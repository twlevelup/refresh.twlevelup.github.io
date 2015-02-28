## Running locally

All changes should be made on the `source` branch. To preview the site locally:

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
