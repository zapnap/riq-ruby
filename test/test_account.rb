require 'minitest/autorun'

require_relative '../lib/riq'

def create_netflix
  RIQ.account('54e6542fe4b01ad3b7362bc4')
end

def create_blank_account
  RIQ.account
end

def create_data_account
  RIQ.account({name: 'Glengarry', field_values: {'0' => 3}})
end

describe RIQ::Account do
  before do
    RIQ.init
  end

  describe '#new' do
    it 'should get account' do
      @netflix = create_netflix
      @netflix.name.must_equal 'Netflix'
    end

    it 'should make blank account' do
      @a = create_blank_account
      @a.wont_be_nil
    end

    it 'should take a data hash' do 
      @dat = create_data_account
      @dat.name.wont_be_nil
    end
  end

  describe '#save' do 
    it 'should create new account' do
      @a = create_blank_account
      @a.name = 'Delete Test Inc'
      @a.field_value(2, '1')
      @a.save

      @a.id.wont_be_nil
    end
  end

  describe "#field_value" do
    it 'should fetch a field value' do 
      @netflix = create_netflix
      @netflix.field_value(2).wont_be_nil
      @dat = create_data_account
      @dat.field_value(0).wont_be_nil
    end
  end
end