require_relative '../spec_helper'

RSpec.describe 'ATMsRepository' do
  let(:atm_repository) { ATMsRepository.instance }
  let(:atm) { ATMs.new(1, 'Downtown') }

  describe '#add_atm' do
    it 'adds an ATM to the repository' do
      atm_repository.add_atm(atm)
      expect(atm_repository.all_atms.size).to eq(1)
      expect(atm_repository.all_atms.first.id).to eq(atm.id)
      expect(atm_repository.all_atms.first.location).to eq('Downtown')
    end
  end

  describe '#delete_atm' do
    it 'deletes an existing ATM' do
      atm_repository.add_atm(atm)
      atm_repository.delete_atm(1)
      expect(atm_repository.all_atms.size).to eq(0)
    end
    it 'raises an error if ATM not found' do
      expect { atm_repository.delete_atm(999) }.to raise_error('ATM not found')
    end
  end
  describe '#all_atms' do
    it 'returns all ATMs' do
      atm_repository.add_atm(atm)
      atms = atm_repository.all_atms
      expect(atms.size).to eq(1)
      expect(atms.first.id).to eq(1)
      expect(atms.first.location).to eq('Downtown')
    end
  end

  describe '#find_by_id' do
    it 'finds an ATM by ID' do
      atm_repository.add_atm(atm)
      found_atm = atm_repository.find_atm_by_id(1)
      expect(found_atm.id).to eq(1)
      expect(found_atm.location).to eq('Downtown')
    end

    it 'returns nil if ATM not found' do
      expect(atm_repository.find_atm_by_id(999)).to be_nil
    end
  end
  describe '#find_atm_by_id!' do
    it 'finds an ATM by ID' do
      atm_repository.add_atm(atm)
      found_atm = atm_repository.find_atm_by_id!(1)
      expect(found_atm.id).to eq(1)
      expect(found_atm.location).to eq('Downtown')
    end

    it 'raises an error if ATM not found' do
      expect { atm_repository.find_atm_by_id!(999) }.to raise_error('ATM not found')
    end
  end
end
