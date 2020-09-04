require 'rails_helper'

describe Customer do
  describe 'associations' do
    it { is_expected.to have_one :virtual_money_account }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }

  end
end