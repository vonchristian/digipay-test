module Api
  module V1
    module AgentsModule
      class WithdrawalsController < ApplicationController

        def create
          @agent      = Agent.find(params[:agent_id])
          transaction = ::VirtualMoneyAccounts::WithdrawalProcessing.new(withdrawal_params)
          if transaction.valid?
            transaction.withdraw!
            render transaction, status: :created
          else
            render transaction.errors, status: :unprocessable_entity
          end
        end

        private
        def withdrawal_params
          params.require(:virtual_money_accounts_withdrawal_processing).
          permit(:customer_account_number, :amount).merge!(agent_account_number: @agent.virtual_money_account.account_number)
        end
      end
    end
  end
end