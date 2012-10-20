# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "heroku-qc-autoscale/version"

Gem::Specification.new do |s|
  s.name        = "heroku-qc-autoscale"
  s.version     = Heroku::QC::Autoscale::VERSION
  s.authors     = ["David Bradford"]
  s.email       = ["david@zerobearing.com"]
  s.homepage    = "https://github.com/zerobearing2/heroku-qc-autoscale"
  s.summary     = %q{Auto scale your QueueClassic workers on Heroku. Inspired by mirthlab's Resque auto scale gem.}
  s.description = %q{Add to a Rails 3.x project to auto scale QueueClassic workers on heroku.}

  s.rubyforge_project = "heroku-qc-autoscale"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_runtime_dependency "heroku-api",      "~> 0.3.2"
  s.add_runtime_dependency "activesupport",   "~> 3.2"
  s.add_runtime_dependency "i18n",            "~> 0.6.0"
  s.add_runtime_dependency "queue_classic",   "~> 2.0"

  s.add_development_dependency "minitest", "~> 3.3.0"
  s.add_development_dependency 'rake'
  s.add_development_dependency "pry"
end
