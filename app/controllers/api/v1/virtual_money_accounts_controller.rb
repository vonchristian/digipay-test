module Api
  module V1
    class VirtualMoneyAccountsController < ApplicationController
      def index
        render json: VirtualMoneyAccountSerializer.new(VirtualMoneyAccount.all.includes(:liability_account)).serializable_hash.to_json
      end

      def show
        @entry = Entry.find(params[:id])
        render json: EntrySerializer.new(@entry).serializable_hash.to_json
      end
    end
  end
end