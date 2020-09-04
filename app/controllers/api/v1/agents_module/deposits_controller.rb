module Api
  module V1
    module AgentsModule
      class DepositsController < ApplicationController

        def create
          @agent      = Agent.find(params[:agent_id])
          transaction = ::VirtualMoneyAccounts::DepositProcessing.new(deposit_params)
          if transaction.valid?
            transaction.deposit!
            render transaction, status: :created
          else
            render transaction.errors, status: :unprocessable_entity
          end
        end

        private
        def deposit_params
          params.require(:virtual_money_accounts_deposit_processing).
          permit(:customer_account_number, :amount).merge!(agent_account_number: @agent.virtual_money_account.account_number)
        end
      end
    end
  end
end