require 'spec_helper'

describe Tablet do
  describe '#new' do
    it 'creates Table objects' do
      expect(Tablet.new).to be_an_instance_of Tablet::Table
    end
  end
end
