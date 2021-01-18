# WOD - Sticky Buy Button (SBB)

It's a Shopify App that displays a fixed add to cart button on Shopify storefronts product pages so the add to cart button is always visible as shoppers scroll down the page. 

See: [Sticky Buy Button on the Shopify App Store](https://apps.shopify.com/sticky-buy-now-button)

## System Requirements

* A Ruby Version Manager (examples: `rvm`, `rbenv`, `chruby`, `asdf`)
  * [rvm](rvm.io)
  * [rbenv](https://github.com/rbenv/rbenv)
* Ruby Version: 2.5.3
* Postgresql 9.3.25
  * Check the [pg gem changelog](https://github.com/ged/ruby-pg/blob/master/History.rdoc#v0184-2015-11-13-michael-granger-gedfaeriemudorg-)) to check the latest version that you could use.
  * If you're using `asdf` version manager to manage different postgresql versions, you can just `asdf install` and it will install the correct postgres version for you.
* Latest version of `git`
* Update to rubygems `gem` version `3.0.6`, or a version later than `3.1.2`
  * [Check out here the latest version here](https://rubygems.org/pages/download) If there's a later release than `3.1.2`, you can safely ignore this warning and update this README to the latest rubygems version. Otherwise...
  * As of Feb 12, 2020, The latest rubygems version, `3.1.2`, is spitting out verbose [`Gem::Specification#rubyforge_project=` deprecations warnings](https://github.com/rubygems/bundler/issues/7555), that are not actionable as of now. If you're like me and you think this could distract you, stick to `3.0.6` for now until a newer version than `3.1.2` comes along.
  * See most recent rubygems version [here](https://rubygems.org/gems/rubygems-update/versions)

## Setup

1. Clone the preorder-now repository:

  ```
  $ git clone git@github.com:incartupsell/sticky-buy-now-button.git
  $ cd sticky-buy-now-button
  ```

2. Install ruby 2.5.3 with your favorite ruby version manager (rvm, rbenv, chruby, asdf):

  #### If you're using rvm
  ```
  $ rvm install 2.5.3
  ```

  #### If you're using rbenv and rbenv-update plugin
  ```
  # Update to the latest version of your rbenv plugins, including ruby-build
  $ rbenv update

  # Then install ruby 2.5.3
  $ rbenv install 2.5.3
  ```

3. Install `bundler` and `bundle install`:

  Make sure you already have `gem` version on at least `3.0.0` (verified via `gem -v`) at this point. Otherwise, you might run into the caveat below, as stated in the [bundler blog](https://bundler.io/blog/2019/01/04/an-update-on-the-bundler-2-release.html):

  > Bundler 2 introduced a new feature that will automatically switch between Bundler v1 and v2 based on the lockfile (Gemfile.lock). This feature is enabled by RubyGems (only on versions 2.7.0+) which unfortunately has a bug when you run Bundler without the appropriate version installed. You may encounter an error message like:

  ```
  Can't find gem bundler (>= 0.a) with executable bundle (Gem::GemNotFoundException)
  ```

  > If you do, it can be fixed by installing the version of Bundler that is declared in the lockfile.

  ```
  $ cat Gemfile.lock | grep -A 1 "BUNDLED WITH"
  BUNDLED WITH
    2.1.4

  $ gem install bundler -v '2.1.4'
  ```

  Otherwise, carry on and just run:

  ```
  $ gem install bundler
  $ bundle install
  ```

4. Setup environment variables.
    
  Configure the environment variables below in your IDE (or install [dotenv](https://github.com/bkeepers/dotenv) in this repo):
  
    ```
    APP_URL=<your wod_subdomain.ngrok.io address>
    JS_SCRIPT_URL=<your wod_subdomain.ngrok.io address>/preorder-now.js
    SHOPIFY_API_KEY=<generate this for yourself in Shopify Partners>
    SHOPIFY_API_KEY_SECRET=<generate this for yourself in Shopify Partners>
    SUPPORT_EMAIL=<add your WOD email here to test emails>
    ```

  Follow [these steps](https://www.notion.so/How-to-Setup-Shopify-Apps-for-Local-Development-9a510b4a12144f5c9d6815b2e7411dee#9afc4709e9894857b87d2aac8cc08b02) to get your Shopify API keys. 

5. Setup database

  Make sure postgresql is already running via:

  ```
  $ pg_ctl start
  ```

  Create database and run migrations:

  ```
  $ rails db:create db:migrate
  # or
  $ rails db:setup

  # Then seed the database with enough data
  # to get the app running without errors
  $ rails db:seed
  ```

6. Run `rails server` on port 8080

  ```
  $ rails server -p 8080
  ```

8. If you've managed to get to point, install your local instance of Sticky Buy Button to a test development store.
