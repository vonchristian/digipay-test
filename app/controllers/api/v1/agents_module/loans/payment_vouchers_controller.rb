module Api
  module V1
    module AgentsModule
      module Loans
        class PaymentVouchersController < ApplicationController
          def show
            @voucher = current_agent.vouchers.find(params[:id])
          end
        end
      end
    end
  end
end
