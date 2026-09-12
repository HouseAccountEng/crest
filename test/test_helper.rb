ENV['RAILS_ENV'] = 'test'

require 'simplecov'
SimpleCov.start do
  skip '/test/'
  # Named rather than left to whatever got loaded: a file nothing exercises is the point
  cover 'lib/**/*.rb'
  # Read by the gemspec, which Bundler evaluates before this line runs, and it holds a constant
  skip 'lib/crest/version.rb'
end
SimpleCov.minimum_coverage 100

require_relative 'dummy/config/environment'

require 'rails/test_help'
