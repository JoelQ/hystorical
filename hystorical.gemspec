# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hystorical/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joel Quenneville"]
  gem.email         = ["joel.quen@gmail.com"]
  gem.description   = %q{Hystorical is a simple solution for managing explicit historical datasets}
  gem.summary       = %q{Hystorical is a simple solution for managing explicit historical datasets}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hystorical"
  gem.require_paths = ["lib"]
  gem.version       = Hystorical::VERSION
end
