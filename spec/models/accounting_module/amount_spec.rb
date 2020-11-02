require 'rails_helper'
require "money-rails/test_helpers"
module AccountingModule
  describe Amount do

    subject { build(:amount) }
    it { is_expected.to_not be_valid }

    describe 'associations' do
      it { is_expected.to belong_to :entry }
      it { is_expected.to belong_to :account }
    end

    describe 'validations' do
      it { is_expected.to validate_presence_of :type }
      it { is_expected.to validate_presence_of :account }
      it { is_expected.to validate_presence_of :entry }
      it {is_expected.to monetize(:amount) }

    end

    describe 'delegations' do
      it { is_expected.to delegate_method(:name).to(:account).with_prefix }
      it { is_expected.to delegate_method(:reference_number).to(:entry) }
      it { is_expected.to delegate_method(:description).to(:entry) }
      it { is_expected.to delegate_method(:entry_date).to(:entry) }
      it { is_expected.to delegate_method(:name).to(:account).with_prefix }
    end

    it ".balance" do
      cash_on_hand = create(:asset)
      revenue      = create(:revenue)
      entry        = build(:entry)
      entry.debit_amounts.build(account: cash_on_hand, amount: 1_000)
      entry.credit_amounts.build(account: revenue, amount: 1_000)
      entry.save!

      expect(entry.amounts.balance).to eql 2_000
      expect(entry.debit_amounts.balance).to eql 1_000
      expect(entry.credit_amounts.balance).to eql 1_000
    end
  end
end
