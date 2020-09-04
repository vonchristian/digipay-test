
class Entry < ApplicationRecord
  belongs_to :commercial_document,   polymorphic: true
  has_many   :credit_amounts,        class_name: 'Amounts::CreditAmount', dependent: :destroy
  has_many   :debit_amounts,         class_name: 'Amounts::DebitAmount', dependent: :destroy
  has_many   :credit_accounts,       class_name: 'Account', through: :credit_amounts, source: :account
  has_many   :debit_accounts,        class_name: 'Account', through: :debit_amounts,  source: :account
  has_many   :amounts,               class_name: "Amount", dependent: :destroy
  has_many   :accounts,              class_name: "Account", through: :amounts

  validates :description, :reference_number, :entry_date, :entry_time, presence: true



  validate :has_credit_amounts?
  validate :has_debit_amounts?
  validate :amounts_cancel?

  accepts_nested_attributes_for :credit_amounts, :debit_amounts, allow_destroy: true

  before_save :set_default_date

  delegate :name,  to: :commercial_document, prefix: true


  private

  def set_default_date
    if entry_date.blank?
      todays_date = ActiveRecord::Base.default_timezone == :utc ? Time.now.utc : Time.now
      self.entry_date = todays_date
    end
  end


  def has_credit_amounts?
    errors[:base] << "Entry must have at least one credit amount" if self.credit_amounts.blank?
  end

  def has_debit_amounts?
    errors[:base] << "Entry must have at least one debit amount" if self.debit_amounts.blank?
  end

  def amounts_cancel?
    errors[:base] << "The credit and debit amounts are not equal" if credit_amounts.balance_for_new_record != debit_amounts.balance_for_new_record
  end
end