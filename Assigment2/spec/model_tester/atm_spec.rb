require_relative '../spec_helper'
require 'byebug'

RSpec.describe 'ATM' do
  let(:atm) { ATMs.new(1, 'Downtown') }

  describe '#setter and getter methods' do
    it 'sets and gets id' do
      atm.id = 1
      expect(atm.id).to eq(1)
    end

    it 'sets and gets location' do
      atm.location = 'Downtown'
      expect(atm.location).to eq('Downtown')
    end
  end
end
