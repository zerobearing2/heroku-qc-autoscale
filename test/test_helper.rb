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

Autoscale.config do |c|
  c.api_key = "123456"
  c.app     = "racehq-test"
  c.mock    = true
  c.scale   = [1, 15, 30, 40, 50]
end

Autoscale.activate!
