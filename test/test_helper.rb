require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require './lib/pvoutput/statistic'
require './lib/pvoutput/pvauth'

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
end
