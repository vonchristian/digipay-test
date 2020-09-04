module Api
  module V1
    module CustomersModule
      class FundTransfersController < ApplicationController

        def create
          @sender = Customer.find(params[:customer_id])
          transaction = ::VirtualMoneyAccounts::FundTransferProcessing.new(fund_transfer_params)
          if transaction.valid?
            transaction.fund_transfer!
            render transaction, status: :created
          else
            render transaction.errors, status: :unprocessable_entity
          end
        end

        private
        def fund_transfer_params
          params.require(:virtual_money_accounts_fund_transfer_processing).
          permit(:receiver_account_number, :amount).merge!(sender_account_number: @sender.virtual_money_account.account_number)
        end
      end
    end
  end
end