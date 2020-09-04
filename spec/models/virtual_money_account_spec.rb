require 'rails_helper'

describe VirtualMoneyAccount do
  describe 'associations' do
    it { is_expected.to belong_to :depositor }
    it { is_expected.to belong_to :liability_account }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :account_number }
    it 'is_expected.to validate_uniqueness_of :account_number' do
      create(:virtual_money_account, account_number: '11111')
      account = build(:virtual_money_account, account_number: '11111')
      account.save
      expect(account.errors[:account_number]).to eql ['has already been taken']
    end

  end
end