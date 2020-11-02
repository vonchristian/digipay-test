require 'rails_helper'

describe Agent do
  describe 'associations' do
    it { is_expected.to have_one :wallet }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :account_name }
  end
end
