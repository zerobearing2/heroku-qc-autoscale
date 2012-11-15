require 'active_support/concern'
require 'active_support/callbacks'
require 'active_support/core_ext/module'
require 'queue_classic'
require 'heroku-api'

require "autoscale/heroku"
require "autoscale/queue_classic/callbacks"
require "heroku-qc-autoscale/version"

module Autoscale
  mattr_accessor :api_key, :app, :mock, :scale, :min, :connect_timeout, :read_timeout, :write_timeout

  # config and activate QC bindings
  def self.config(&block)
    yield(self)
  end

  def self.connect_timeout
    @@connect_timeout||5
  end

  def self.read_timeout
    @@read_timeout||15
  end

  def self.write_timeout
    @@write_timeout||15
  end

  # activate QC queue callbacks
  def self.activate!
    QC::Queue.send(:include, Autoscale::QueueClassic::QueueCallbacks)
  end
end
