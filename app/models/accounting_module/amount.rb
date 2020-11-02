module AccountingModule
  class Amount < ApplicationRecord
    monetize :amount_cents, as: :amount, numericality: true

    belongs_to :entry,               class_name: 'AccountingModule::Entry'
    belongs_to :account,             class_name: 'AccountingModule::Account'

    validates :type, :amount, :entry, :account, presence: true

    delegate :name, :code, to: :account, prefix: true
    delegate :reference_number, :description, :entry_date,  to: :entry

    def self.balance(args={})
      total = pluck(:amount_cents).sum
      Money.new(total).amount
    end

    def self.balance_for_new_record
      balance = BigDecimal('0')
      self.all.each do |amount_record|
        if amount_record.amount && !amount_record.marked_for_destruction?
          balance += amount_record.amount # unless amount_record.marked_for_destruction?
        end
      end
      return balance
    end

    private
  end
end
