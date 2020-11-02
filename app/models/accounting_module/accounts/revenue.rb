module AccountingModule
  module Accounts
    class Revenue < AccountingModule::Account
      self.normal_credit_balance = true

      def self.balance(options={})
        super(options)
      end

      def balance(options={})
        super(options)
      end
    end
  end
end
