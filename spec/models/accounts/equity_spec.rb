require 'spec_helper'

module Accounts
  describe Equity do
    it_behaves_like 'an Account subtype', kind: :equity, normal_balance: :credit
  end
end
