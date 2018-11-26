require 'json'
require 'date'

class ParseJson

  attr_accessor :json_file, :date_split, :date_length_array, :key_type_array

  def initialize(json_file)
    @json_file = JSON.parse(File.read(json_file))
    @date_split_array = []
    @date_length_array = []
    @key_type_array = []
    @rate_keys_array = []
  end

  def get_base
    json_file["base"]
  end

  def get_number_of_rates
    number_of_rates = json_file["rates"].length
    number_of_rates
  end

  def check_date_format
    @date_split_array = json_file["date"].split("-")
    @date_split_array.each do |value|
      @date_length_array << value.length
    end
    @date_length_array
  end

  def check_date_validity
    @date_split_array = json_file["date"].split("-")
    Date.valid_date? @date_split_array[0].to_i, @date_split_array[1].to_i, @date_split_array[2].to_i
  end

  def check_key_type
    correct_formats = 0
    json_file["rates"].keys.each do |key|
      key_type_array << key.class
    end
    key_type_array.each do |i|
      if i == String
        correct_formats +=1
      end
    end
    if correct_formats == json_file["rates"].length
      true
    else
      false
    end
  end

  def check_exchange_rates
    valid_rate = 0
    json_file["rates"].values.each do |value|
      if value > 0
        valid_rate +=1
      end
    end
    if valid_rate == json_file["rates"].length
      true
    else
      false
    end
  end

  def check_rate_key_format
    correct_formats = 0
    json_file["rates"].keys.each do |key|
      @rate_keys_array << key
    end
    @rate_keys_array.each do |value|
      case value
      when /^[A-Z]*$/
        correct_formats +=1
      end
      if value.length == 3
        correct_formats +=1
      end
    end
    if correct_formats == (json_file["rates"].length * 2)
      true
    else
      false
    end
  end
end
