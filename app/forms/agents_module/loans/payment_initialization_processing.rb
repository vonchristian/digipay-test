module AgentsModule
  module Loans
    class PaymentInitializationProcessing
      attr_accessor :loan_id, :agent_id, :voucher_account_number, :receivable_amount, :interest_amount, :penalty_amount

      def initialize_payment!
        voucher = find_agent.vouchers.build(
          description: "Loan payment",
          commercial_document: find_loan,
          account_number: voucher_account_number
        )
        voucher.debit_amounts.build(
          account: find_agent.virtual_money_account,
          amount: total_amount
        )
        create_principal_amount_for(voucher)
        create_interest_amount_for(voucher)
        create_penalty_amount_for(voucher)

        voucher.save!
    end

    private

    def create_principal_amount_for(voucher)
      if principal_amount.to_f > 0
        voucher.credit_amounts.build(
          account: find_loan.receivable_account,
          amount: principal_amount
        )
      end
    end

    def create_interest_amount_for(voucher)
      if interest_amount.to_f > 0
        voucher.credit_amounts.build(
          account: find_loan.interest_revenue_account,
          amount: interest_amount
        )
      end
    end

    def create_penalty_amount_for(voucher)
      if penalty_amount.to_f > 0
        voucher.credit_amounts.build(
          account: find_loan.penalty_revenue_account,
          amount: penalty_amount
        )
      end
    end

    def total_amount
      principal_amount.to_f + interest_amount.to_f + penalty_amount.to_f
    end
    def find_loan
      if loan_id.present?
        LoansModule::Loan.find(loan_id)
      end
    end
  end
end
