# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rms_web_service/version'

Gem::Specification.new do |spec|
  spec.name          = "rms_web_service"
  spec.version       = RmsWebService::VERSION
  spec.authors       = ["kamiya54"]
  spec.email         = ["kamiya54@gmail.com"]
  spec.summary       = %q{Ruby wrapper for RMS Web Service.}
  spec.description   = %q{Ruby wrapper for RMS Web Service.}
  spec.homepage      = "https://github.com/kamiya54/rms_web_service"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "nokogiri"
  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "guard-rspec"
end
