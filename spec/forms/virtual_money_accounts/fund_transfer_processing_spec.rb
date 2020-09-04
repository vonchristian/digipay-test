require 'rails_helper'

module VirtualMoneyAccounts
  describe FundTransferProcessing do
    describe 'attributes' do
      it { is_expected.to respond_to :sender_account_number }
      it { is_expected.to respond_to :receiver_account_number }
      it { is_expected.to respond_to :amount }
    end

    it "#withdraw!" do
      cash      = create(:asset)
      customer1 = create(:customer)
      customer2 = create(:customer)

      customer1_virtual_money_account = create(:virtual_money_account, depositor: customer1, account_number: '1111')
      customer2_virtual_money_account = create(:virtual_money_account, depositor: customer2, account_number: '2222')

      entry = build(:entry)
      entry.debit_amounts.build(amount: 10_000, account: cash)
      entry.credit_amounts.build(amount: 10_000, account: customer1_virtual_money_account.liability_account)
      entry.save!

      expect(customer2_virtual_money_account.balance.to_f).to eql 0.0
      expect(customer1_virtual_money_account.balance.to_f).to eql 10_000.0

      described_class.new(sender_account_number: '1111', receiver_account_number: '2222', amount: 5_000).fund_transfer!

      expect(customer1_virtual_money_account.balance.to_f).to eql 5_000.0
      expect(customer1_virtual_money_account.balance.to_f).to eql 5_000.0
    end





  end
end