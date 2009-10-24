$: << File.join(File.dirname(__FILE__), '..', 'lib')
$: << File.join(File.dirname(__FILE__))

require 'rubygems'

require 'factory_girl'

if ENV['DATAMAPPER'] 
  require 'dm-core'
  require 'dm-validations'
  # because DataMapper uses include instead of inheritance,
  # we must load these first.
  require 'factory_girl/syntax/generate'
  require 'factory_girl/syntax/blueprint'
  require 'factory_girl/syntax/make'
  require 'dm-models'
else
  require 'activerecord'
  require 'models'
end

require 'spec'
require 'spec/autorun'
require 'rr'



Spec::Runner.configure do |config|
  config.mock_with RR::Adapters::Rspec
end
