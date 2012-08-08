# test/test_helper.rb

ENV["TEST"] = 'true'
ENV["DATABASE_URL"] ||= "postgres:///queue_classic_test"

$:.unshift File.expand_path("../../lib")
require 'rubygems'
require 'minitest/autorun'
require 'pry'
require 'time'

require 'heroku-qc-autoscale'
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

Heroku::QC::Autoscale.config do |c|
  c.api_key = "123456"
  c.app     = "racehq-test"
  c.mock    = true
  c.scale   = [1, 15, 30, 40, 50]
  c.active  = true
end

# borrowed from heroku-api test helper
def with_app(params={}, &block)
  params.merge!('name' => Heroku::QC::Autoscale.app) unless params.key?("name")
  heroku = Heroku::Scaler.client
  
  begin
    data = heroku.post_app(params).body
    @name = data['name']
    ready = false
    until ready
      ready = heroku.request(:method => :put, :path => "/apps/#{@name}/status").status == 201
    end
    yield(data)
  ensure
    heroku.delete_app(@name) rescue nil
  end
end