require 'spec_helper'

module AccountingModule
  module Accounts
    describe Equity do
      it_behaves_like 'an AccountingModule::Account subtype', kind: :equity, normal_balance: :credit
    end
  end
end
