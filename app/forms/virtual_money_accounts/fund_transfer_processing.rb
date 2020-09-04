module VirtualMoneyAccounts
  class FundTransferProcessing
    include ActiveModel::Model
    attr_accessor :sender_account_number, :receiver_account_number, :amount

    validates :sender_account_number, :receiver_account_number, :amount, presence: true
    validates :amount, numericality: true

    def fund_transfer!
      ApplicationRecord.transaction do
        create_entry
      end
    end

    private

    def create_entry
      if balance_available?
        entry = Entry.new(commercial_document: sender_account.depositor, reference_number: 'fund transfer', description: 'fund transfer transaction', entry_date: Date.current, entry_time: Time.zone.now)
        entry.debit_amounts.build(amount: amount, account: sender_account.liability_account)
        entry.credit_amounts.build(amount: amount, account: receiver_account.liability_account)
        entry.save!
      end
    end

    def receiver_account
      VirtualMoneyAccount.find_by!(account_number: receiver_account_number).lock!
    end

    def sender_account
      VirtualMoneyAccount.find_by!(account_number: sender_account_number).lock!
    end

    def balance_available?
      sender_account.balance.to_f >= amount.to_f
    end
  end
end