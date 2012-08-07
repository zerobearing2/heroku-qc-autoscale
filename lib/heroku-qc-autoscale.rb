require 'active_support/concern'
require 'active_support/callbacks'
require 'active_support/core_ext/module'
require 'queue_classic'
require 'heroku-api'

require "heroku-qc-autoscale/version"

require "qc/callbacks"
require "qc/auto_scale"
require "qc/queue"
require "heroku/scaler"

module Heroku
  module QC
    module Autoscale
      mattr_accessor :api_key, :app, :mock

      def self.config(&block)
        yield(self)
      end

      def self.heroku_params
        {
          api_key: self.api_key  || ENV['HEROKU_API_KEY'],
          mock:    self.mock     || false
        }
      end
      
    end
  end
end
