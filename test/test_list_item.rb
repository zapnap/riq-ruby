require_relative 'test_helper'

def create_blank_list_item
  @l.list_item
end

def create_first
  @l.list_items.first
end

describe RIQ::ListItem do
  before do
    lid = '5620d3e8e4b01bbcd7f9e7b2'
    @l = RIQ.list(lid)
  end

  describe '#field_value' do
    it 'should return a value' do
      @li = create_first
      @li.field_value(0).wont_be_nil

      @blank = create_blank_list_item
      @blank.field_value(0).must_be_nil
    end
  end

  describe '#save' do
    it 'should create and delete' do
      @blank = create_blank_list_item
      @blank.field_value(0, 1)
      @blank.contact_ids << RIQ.contacts.first.id
      @blank.save
      @blank.id.wont_be_nil

      assert(@blank.delete)
    end

    it 'should update' do
      @li = create_first
      start = @li.field_value(0)
      if start == '1'
        @li.field_value(0, 0)
      else
        @li.field_value(0, 1)
      end
      @li.save

      @li.field_value(0).wont_equal start
    end

    it 'should fail without a list id' do
      @li = RIQ::ListItem.new
      begin
        @li.save
      rescue RIQ::RIQError
        assert(true)
      else
        assert(false)
      end
    end
  end
end
