require 'rails_helper'

module AccountingModule
  describe Entry do
  	describe 'associations' do
  		it { is_expected.to belong_to :commercial_document }
      it { is_expected.to have_many :credit_amounts }
      it { is_expected.to have_many :debit_amounts }
      it { is_expected.to have_many :debit_accounts }
      it { is_expected.to have_many :credit_accounts }
      it { is_expected.to have_many :accounts }
      it { is_expected.to have_many :amounts }
  	end

    describe 'validations' do
      it { is_expected.to validate_presence_of :description }
      it { is_expected.to validate_presence_of :reference_number }
      it { is_expected.to validate_presence_of :entry_date }
      it { is_expected.to validate_presence_of :entry_time }
      it '#has_credit_amounts?' do
        entry = build(:entry)
        credit_amount = build(:credit_amount, entry: entry)
        entry.save

        expect(entry).to_not be_valid
      end

      it '#has_debit_amounts?' do
        entry        = build(:entry)
        debit_amount = build(:debit_amount, entry: entry, amount: 100)
        entry.save

        expect(entry).to_not be_valid
      end

      it "#amounts_cancel?" do
        cash_on_hand = create(:asset)
        revenue      = create(:revenue)
        deprecation  = create(:asset)
        property     = create(:asset)
        entry        = build(:entry)
        entry.debit_amounts.build(account: cash_on_hand, amount: 100)
        entry.debit_amounts.build(account: deprecation, amount: 100)
        entry.credit_amounts.build(account: revenue, amount: 100)
        entry.credit_amounts.build(account: property, amount: 100)

        entry.save!

        expect(entry).to be_valid
      end
    end

    describe 'delegations' do
      it { is_expected.to delegate_method(:name).to(:commercial_document).with_prefix }

    end

    describe 'nested_attributes' do
      it { is_expected.to accept_nested_attributes_for(:debit_amounts) }
      it { is_expected.to accept_nested_attributes_for(:credit_amounts) }
    end
  end
end
