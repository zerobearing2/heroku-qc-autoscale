require 'active_support/concern'
require 'active_support/callbacks'
require 'active_support/core_ext/module'
require 'queue_classic'
require 'heroku-api'

require "autoscale/heroku"
require "autoscale/queue_classic/callbacks"
require "heroku-qc-autoscale/version"

module Autoscale
  mattr_accessor :api_key, :app, :mock, :scale, :active

  # config and activate QC bindings
  def self.config(&block)
    yield(self)
    activate if active == true
  end

  # activate QC queue callbacks
  def self.activate
    QC::Queue.send(:include, Autoscale::QueueClassic::QueueCallbacks)
  end
end
