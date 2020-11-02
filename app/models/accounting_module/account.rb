module AccountingModule
  class Account < ApplicationRecord
    TYPES = ['Asset', 'Liability', 'Equity', 'Revenue', 'Expense']

    class_attribute :normal_credit_balance

    has_many :amounts
    has_many :credit_amounts, :class_name => 'Amounts::CreditAmount'
    has_many :debit_amounts,  :class_name => 'Amounts::DebitAmount'
    has_many :entries,        through: :amounts, source: :entry, class_name: "Entry"
    has_many :credit_entries, :through => :credit_amounts, :source => :entry, :class_name => 'Entry'
    has_many :debit_entries,  :through => :debit_amounts, :source => :entry, :class_name => 'Entry'


    validates :type, :name, :code, presence: true
    validates :name, uniqueness: true

    def self.balance(options={})
      accounts_balance = BigDecimal('0')
      self.all.each do |account|
        if account.contra?
          accounts_balance -= account.balance(options)
        else
          accounts_balance += account.balance(options)
        end
      end
      accounts_balance
    end


    def self.debits_balance(options={})
      accounts_balance = BigDecimal('0')
      self.all.each do |account|
        if account.contra?
          accounts_balance -= account.debits_balance(options)
        else
          accounts_balance += account.debits_balance(options)
        end
      end
      accounts_balance
    end

    def self.credits_balance(options={})
      accounts_balance = BigDecimal('0')
      self.all.each do |account|
        if account.contra
          accounts_balance -= account.credits_balance(options)
        else
          accounts_balance += account.credits_balance(options)
        end
      end
      accounts_balance
    end

    def self.trial_balance(args={})
      if self.new.class == Account
        Accounts::Asset.balance(args) - (Accounts::Liability.balance(args) + Accounts::Equity.balance(args) + Accounts::Revenue.balance(args) - Accounts::Expense.balance(args))
      else
        raise(NoMethodError, "undefined method 'trial_balance'")
      end
    end

    def balance(options={})
      return raise(NoMethodError, "undefined method 'balance'") if self.class == Account

      if normal_credit_balance ^ contra?
        credits_balance(options) - debits_balance(options)
      else
        debits_balance(options) - credits_balance(options)
      end
    end


    def credits_balance(args={})
      credit_amounts.balance(args)
    end

    def debits_balance(args={})
      debit_amounts.balance(args)
    end
  end
end
