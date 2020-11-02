module Api
  module V1
    module AgentsModule
      module Loans
        class PaymentInitializationsController < ApplicationController
          def create
            @voucher_reference_number = SecureRandom.uuid
            @agent                    = current_agent
            @loan_payment             = AgentsModule::Loans::PaymentInitialization.new(loan_payment_params)
            @loan_payment.initialize_payment!
          end

          private
          def loan_payment_params
            params.require(:agents_module_loans_payment_initialization).
            permit(:principal_amount, :interest_amount, :penalty_amount).
            merge!(agent_id: @agent.id, voucher_account_number: @voucher_account_number)
        end
      end
    end
  end
end
