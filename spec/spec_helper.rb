$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rms_web_service'
require 'webmock/rspec'

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(File.join(fixture_path, file))
end

require 'coveralls'
Coveralls.wear!
