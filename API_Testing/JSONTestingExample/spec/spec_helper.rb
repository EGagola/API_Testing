require 'json'
require 'dotenv' # To help access environment variables
require 'httparty' # To help make HTTP requests in ruby

require_relative '../json_parsing_walkthrough'

Dotenv.load('.env')

RSpec.configure do |config|
  config.formatter = :documentation
  config.color = true
end
