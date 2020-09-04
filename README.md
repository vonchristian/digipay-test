
# Sample API for virtual money deposits/withdrawals

This applications requires Ruby 2.7 and Rails 6.0
This application supports concurrent transactions by locking each account during each transaction. Please see
`app/forms/*.rb` for implementing pessimistic locking on transactions.

To setup application run:

```
rails db:create
rails db:migrate
rails db:seed
```

## Seed Data
Note: Please see `db/seeds.rb` for possible data to be used for testing the API endpoints.
```
Agents
id: "a4263393-fa16-4b5b-a84e-d0ff24850abe"  account_name: 'Digipay Agent 001' account_number: 'Agent-001'   balance: 100_000
id: "c426901f-68aa-4da4-969a-71a09dd4a9b7"  account_name: 'Digipay Agent 002' account_number: 'Agent-002'  balance: 100_000

Customers
id: "e9d5ef64-e92c-4116-94fb-313a87a93aaf"  account_name: Juan Cruz account_number: '1111-1111'   balance: 0
id: "1f21fb48-04f9-436a-95f2-972ee0878db9"  account_name: Danny Lark account_number: '2222-2222'  balance: 0

```



## API Endpoints
### Viewing of all virtual money accounts and its balances
Viewing of all accounts can be accessed at:
```
localhost:3000/api/v1/virtual_money_accounts
```

### Viewing of all transactions
Each transaction is implemented using double-entry bookkeeping. Viewing all transactions can be accessed at:
```
localhost:3000/api/v1/transactions
```
### Processing deposits

Processing deposits requires an Agent ID (assuming this transaction will be processed on an Agent's device) can be tested at:
```
localhost:3000/api/v1/agents/{agent_id}/deposits
```
Example test of processing deposits using curl:
```
curl --header "Content-Type: application/json" --request POST --data '{"virtual_money_accounts_deposit_processing": { "amount": "10000", "customer_account_number": "2222-2222" }}' http://localhost:3000/api/v1/agents/"a4263393-fa16-4b5b-a84e-d0ff24850abe"/deposits
```
### Processing withdrawals

Processing withdrawals requires an Agent ID (assuming this transaction will be processed on an Agents device) can be tested at:
```
localhost:3000/api/v1/agents/{agent_id}/withdrawals
```
Example test of processing withdrawals using curl:
```
curl --header "Content-Type: application/json" --request POST --data '{"virtual_money_accounts_withdrawal_processing": { "amount": "10000", "customer_account_number": "1111-1111" }}' http://localhost:3000/api/v1/agents/"a4263393-fa16-4b5b-a84e-d0ff24850abe"/withdrawals
```

### Processing fund transfers

Processing fund transfers requires a Customer ID (assuming this transaction will be processed on a Customer's device) can be tested at:
```
localhost:3000/api/v1/customers/{customer_id}/fund_transfers
```
Example test of processing fund transfers using curl:
```
curl --header "Content-Type: application/json" --request POST --data '{"virtual_money_accounts_fund_transfer_processing": { "amount": "10000", "receiver_account_number": "1111-1111" }}' http://localhost:3000/api/v1/virtual_money_accounts/"e9d5ef64-e92c-4116-94fb-313a87a93aaf"/fund_transfers
```