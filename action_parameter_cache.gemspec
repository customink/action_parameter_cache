# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "action_parameter_cache/version"

Gem::Specification.new do |s|
  s.name        = "action_parameter_cache"
  s.version     = ActionParameterCache::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Scott Laird", "Stafford Brunk"]
  s.email       = ["sbrunk@customink.com"]
  s.homepage    = ""
  s.summary     = %q{This is an alternative to caches_action which allows you to cache actions that don't all go to unique url's but can be differentiated by the parameters that are passed in.}
  s.description = %q{This is an alternative to caches_action which allows you to cache actions that don't all go to unique url's but can be differentiated by the parameters that are passed in.  It provides the following syntax: caches_action_with_parameters :search, :parameters => [:keyword]}

  s.rubyforge_project = "action_parameter_cache"
  
  s.add_development_dependency "rspec", "~> 2.6.0"
  s.add_dependency "actionpack"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
