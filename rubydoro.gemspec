# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rubydoro/version"

Gem::Specification.new do |s|
  s.name        = "rubydoro"
  s.version     = Rubydoro::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Michishige Kaito"]
  s.email       = ["me@mkaito.com"]
  s.homepage    = ""
  s.summary     = %q{Pomodoro timer for the console}
  s.description = %q{Rubydoro is a timer application for the console, written in Ruby}

  s.add_dependency('trollop', '>= 1.16.2')
  # s.add_dependency('trollop', '>= 1.16.2')
  s.add_development_dependency('rspec')

  s.rubyforge_project = "rubydoro"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
