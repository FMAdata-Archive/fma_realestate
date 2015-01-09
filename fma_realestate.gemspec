# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fma_realestate/version'

Gem::Specification.new do |spec|
  spec.name          = "fma_realestate"
  spec.version       = FmaRealestate::VERSION
  spec.authors       = ["Blaine Johnson"]
  spec.email         = ["customer.service@firstmoversadvantage.com"]
  spec.summary       = "FMA Real Estate and CASS Ruby Client"
  # spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "http://realestate.firstmoversadvantage.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'excon', '~> 0.37'
  spec.add_dependency 'json', '~> 1.8.1'
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
