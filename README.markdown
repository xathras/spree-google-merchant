SpreeGoogleBase
===============

This extension allows you to use Google Base to list products for free that will appear in Google Product Search (http://www.froogle.com/).

<a href="http://base.google.com/support/bin/answer.py?answer=25277&topic=2904">Learn more about Google Base</a>

INSTALLATION
------------

1. Create google base account. Create google base ftp account (if applicable). Create data feed in google base with a type "Products" and name "google_base.xml".

2. Install the extension with one of the following commands

      Add `gem "spree_google_base"`
      Run `bundle install`
      Run `rake db:migrate`
      Run `rake spree_google_base:install`

3. Edit product_type, priorities in spree admin (/admin/taxon_map).

4. Set preferences (can be found in spree_google_base/lib/google_base_configuration.rb)  for the feed title, public domain, feed description, ftp login and password. FTP login is not required - you may schedule upload from the public directory.

5. Issue the command 'rake spree_google_base:generate' to generate feed. Verify feed exists (YOUR_APP_ROOT/public/google_base.xml).


CRONJOBS
--------

There are two options to regulate google base product update:

A) Setup cronjobs to run 'rake spree_google_base:generate' and 'rake spree_google_base:transfer'


Development of this extension is sponsored by [End Point][1] and by [FCP Groton][2].

[1]: http://www.endpoint.com/
[2]: http://www.fcpgroton.com/
