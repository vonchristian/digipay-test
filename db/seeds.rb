
cash_in_bank = Accounts::Asset.create(name: 'FSG Cash in Bank', code: 1111)
capital      = Accounts::Equity.create(name: 'Capital', code: 2222)
fsg_agent    = Agent.create(account_name: 'FSG Agent')
#entry for starting capital/investment
Entry.create!(
  commercial_document: fsg_agent,
  reference_number: 'investment',
  description: 'Initial Investment',
  entry_date: Date.current,
  entry_time: Time.zone.now,
  debit_amounts_attributes: [amount: 1_000_000, account: cash_in_bank],
  credit_amounts_attributes: [amount: 1_000_000, account: capital]
)
#create accounts for virtual money
agent1_account    = Accounts::Liability.create!(name: 'Agent01 Account', code: 313213)
agent2_account    = Accounts::Liability.create!(name: 'Agent02 Account', code: 34322)
customer1_account = Accounts::Liability.create!(name: 'Juan Cruz Account', code: 3432432)
customer2_account = Accounts::Liability.create!(name: 'Danny Lark Account', code: 343092432)
#create agents and virtual money accounts
agent1 = Agent.create!(id: "a4263393-fa16-4b5b-a84e-d0ff24850abe", account_name: 'Digipay Agent 001')
agent2 = Agent.create!(id: "c426901f-68aa-4da4-969a-71a09dd4a9b7", account_name: 'Digipay Agent 002')

VirtualMoneyAccount.create!(depositor: agent1, liability_account: agent1_account, account_number: 'Agent-001')
VirtualMoneyAccount.create!(depositor: agent2, liability_account: agent2_account, account_number: 'Agent-002')

#create customers and virtual money accounts
customer1 = Customer.create!(id: "e9d5ef64-e92c-4116-94fb-313a87a93aaf", first_name: 'Juan', last_name: 'Cruz')
customer2 = Customer.create!(id: "1f21fb48-04f9-436a-95f2-972ee0878db9", first_name: 'Danny', last_name: 'Lark')
VirtualMoneyAccount.create!(depositor: customer1, liability_account: customer1_account, account_number: '1111-1111')
VirtualMoneyAccount.create!(depositor: customer2, liability_account: customer2_account, account_number: '2222-2222')

#load up agents with PHP 100_000 each

Entry.create!(
  commercial_document: agent1,
  reference_number: 'load up agent 1',
  description: 'load up agent 1',
  entry_date: Date.current,
  entry_time: Time.zone.now,
  debit_amounts_attributes: [amount: 100_000, account: cash_in_bank],
  credit_amounts_attributes: [amount: 100_000, account: agent1_account]
)

Entry.create!(
  commercial_document: agent2,
  reference_number: 'load up agent 2',
  description: 'load up agent 2',
  entry_date: Date.current,
  entry_time: Time.zone.now,
  debit_amounts_attributes: [amount: 100_000, account: cash_in_bank],
  credit_amounts_attributes: [amount: 100_000, account: agent2_account]
)