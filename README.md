Autoscale QueueClassic workers on Heroku
==================

Add to a Rails 3.x project to auto scale QueueClassic workers on heroku.


Usage
-----
    gem install heroku-qc-autoscale

Create config/initializers/qc_autoscale.rb

    Heroku::QC::Autoscale.config do |c|
      c.api_key = ENV['HEROKU_API_KEY']
      c.app     = ENV['HEROKU_APP']
      c.scale   = [1, 15, 30, 40, 50]
      c.active  = Rails.env.production?
    end

Queue jobs as normal with QueueClassic

    QC.enqueue("Time.now")


Meta
----

Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).