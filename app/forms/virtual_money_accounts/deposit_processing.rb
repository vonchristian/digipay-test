module VirtualMoneyAccounts
  class DepositProcessing
    include ActiveModel::Model
    attr_accessor :customer_account_number, :agent_account_number, :amount

    validates :agent_account_number, :customer_account_number, :amount, presence: true
    validates :amount, numericality: true

    def deposit!
      ApplicationRecord.transaction do
        create_entry
      end
    end

    private

    def create_entry
      if agent_balance_available?
        entry = Entry.new(commercial_document: customer_account.depositor, reference_number: 'deposit', description: 'deposit transaction', entry_date: Date.current, entry_time: Time.zone.now)
        entry.debit_amounts.build(amount: amount, account: agent_account.liability_account)
        entry.credit_amounts.build(amount: amount, account: customer_account.liability_account)
        entry.save!
      end
    end

    def customer_account
      VirtualMoneyAccount.find_by!(account_number: customer_account_number).lock!
    end

    def agent_account
      VirtualMoneyAccount.find_by!(account_number: agent_account_number).lock!
    end

    def agent_balance_available?
      agent_account.balance.to_f >= amount.to_f
    end
  end
end