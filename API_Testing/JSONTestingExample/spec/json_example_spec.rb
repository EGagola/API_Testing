describe 'Testing the exchange rates' do

  before(:each) do
    @api_key = ENV['FIXER_API_KEY']
    @exchange_rates = ParseJson.new(HTTParty::get("http://data.fixer.io/api/latest?access_key=#{@api_key}").body)
  end

  it 'Should be a hash' do
    expect(@exchange_rates.json_file).to be_kind_of(Hash)
  end

  it 'should have a base of EUR' do
    expect(@exchange_rates.get_base).to eq "EUR"
  end

  it 'should have 168 rates for comparison' do
    expect(@exchange_rates.get_number_of_rates).to eq 168
  end

  it 'should have the correct format of date' do
    expect(@exchange_rates.get_date).to be_kind_of(String)
    expect(@exchange_rates.check_date_format).to eq [4,2,2]
  end

  it 'should contain a valid date' do
    expect(@exchange_rates.check_date_validity).to eq true
  end

  it 'should have strings for every key' do
    expect(@exchange_rates.check_key_type).to eq true
  end

  it 'should not have any exchange rates below 0' do
    expect(@exchange_rates.check_exchange_rates).to eq true
  end

  it "should have rate keys that are all uppercase and of the right length" do
    expect(@exchange_rates.check_rate_key_format).to eq true
  end

  it "should contain a hash of length 5" do
    expect(@exchange_rates.get_hash_length).to eq 5
  end

  it "should all rates should be Floats" do
    @exchange_rates.get_rates.each_value {|value| expect(value).to be_kind_of(Float).or be_kind_of(Integer)}
  end
end
