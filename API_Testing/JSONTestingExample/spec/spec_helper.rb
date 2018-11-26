require 'json'
require 'dotenv' # To help access environment
require 'httparty'

require_relative '../json_parsing_walkthrough'

RSpec.configure do |config|
  config.formatter = :documentation
  config.color = true
end
