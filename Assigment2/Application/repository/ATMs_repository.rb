require_relative '../errors/validation_error'
require_relative '../model/ATMs'
require 'singleton'

class ATMsRepository
  include Singleton
  def initialize
    @atms = []
  end

  def add_atm(atm)
    @atms << atm
  end

  def all_atms
    @atms
  end

  def delete_atm(atm_id)
    atm = find_atm_by_id!(atm_id)
    raise ValidationError, 'ATM not found' if atm.nil?

    @atms.reject! { |atm| atm.id == atm_id }
  end

  def find_atm_by_id!(atm_id)
    atm = find_atm_by_id(atm_id)
    raise ValidationError, 'ATM not found' unless atm

    atm
  end

  def find_atm_by_id(atm_id)
    @atms.find { |atm| atm.id == atm_id }
  end

  def clear
    @atms.clear
  end
end
