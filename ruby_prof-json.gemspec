# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ruby_prof-json/version"

Gem::Specification.new do |s|
  s.name        = "ruby_prof-json"
  s.version     = Rubyprof::Json::VERSION
  s.authors     = ["Andrew O'Brien"]
  s.email       = ["obrien.andrew@gmail.com"]
  s.homepage    = "http://github.com/AndrewO/ruby_prof-json"
  s.summary     = %q{Outputs ruby-prof results as JSON.}
  s.description = %q{If you need to process results from a profiling session, JSON is a good place to start.}

  s.rubyforge_project = "ruby_prof-json"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "json_pure"
  s.add_runtime_dependency "ruby-prof"
end
