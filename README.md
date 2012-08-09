Autoscale QueueClassic workers on Heroku
==================

Add to a Rails 3.x project to auto scale QueueClassic workers on heroku.

**WARNING: USE AT OWN RISK! THIS GEM IS CONSIDERED EXTREME ALPHA!**

[![Build Status](https://secure.travis-ci.org/zerobearing2/heroku-qc-autoscale.png)](http://travis-ci.org/zerobearing2/heroku-qc-autoscale)


Usage
-----

Install as gem
    
    gem install heroku-qc-autoscale

Add to Gemfile

    gem "heroku-qc-autoscale"


Create config/initializers/qc_autoscale.rb

    Autoscale.config do |c|
      c.api_key = ENV['HEROKU_API_KEY']
      c.app     = ENV['AUTOSCALE_APP']
      c.min     = ENV['AUTOSCALE_MIN']
      c.scale   = [1, 15, 30, 40, 50]
    end

    Autoscale.activate! if Rails.env.production?

Queue jobs as normal with QueueClassic. Based on your scale table, it will recalculate the 
workers required after each QC#enqueue, and QC#delete.

    QC.enqueue("Time.now")


Meta
----

Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).