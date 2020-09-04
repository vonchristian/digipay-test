require 'rails_helper'

module VirtualMoneyAccounts
  describe WithdrawalProcessing do
    describe 'attributes' do
      it { is_expected.to respond_to :customer_account_number }
      it { is_expected.to respond_to :agent_account_number }
      it { is_expected.to respond_to :amount }
    end

    it "#withdraw!" do
      cash  = create(:asset)
      agent = create(:agent)
      customer = create(:customer)
      agent_virtual_money_account = create(:virtual_money_account, depositor: agent, account_number: 'Agent-001')
      customer_virtual_money_account = create(:virtual_money_account, depositor: customer, account_number: '1111')

      entry = build(:entry)
      entry.debit_amounts.build(amount: 10_000, account: cash)
      entry.credit_amounts.build(amount: 10_000, account: customer_virtual_money_account.liability_account)
      entry.save!

      expect(agent_virtual_money_account.balance.to_f).to eql 0.0
      expect(customer_virtual_money_account.balance.to_f).to eql 10_000.0

      described_class.new(customer_account_number: '1111', agent_account_number: 'Agent-001', amount: 5_000).withdraw!

      expect(agent_virtual_money_account.balance.to_f).to eql 5_000.0
      expect(customer_virtual_money_account.balance.to_f).to eql 5_000.0
    end





  end
end