module Api
  module V1
    class TransactionsController < ApplicationController
      def index
        options = {}
        options[:include] = [:debit_amounts, :'debit_amounts.account']
        render json: EntrySerializer.new(Entry.all.includes(:debit_amounts, :credit_amounts).order(created_at: :desc)).serializable_hash.to_json
      end

      def show
        @entry = Entry.find(params[:id])
        render json: EntrySerializer.new(@entry).serializable_hash.to_json
      end
    end
  end
end