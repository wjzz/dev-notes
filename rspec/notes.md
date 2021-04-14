# RSpec notes

Syntax highlighting for test outputs
```
gem install coderay
```

```rb
pending 'this marks the rest of the test as pending'
```

```
rspec --profile 2        # shows 2 slowest examples
rspec -e milk            # run only tests containing 'milk'
rpsec --tag hello:true   # tag filtering
```

Config

```
config.include ExampleModule
```

shared_context
include_context

## Keywords

context = describe
it = example = specify

## Tag aliases

rspec.alias_example_group_to :pdescribe, pry: true
rspec.alias_example_to :pit, pry: true

## Hooks

Run DB tests in transactions

```
c.around(:example, :db) do |example|
  DB.transaction(rollback: :always) { example. run }
end
```

Various hooks

```
before { ... }       # runs before every test in given group
before(:each)
before(:example)
after { ... }        # runs after every test in given group

before(:all) { .. }
before(:context) { .. }

# available only in the config file
before(:suite) { ... }
after(:suite) { ... }
```

## Matchers

```rb
expect([1,2,3]).not_to be_empty
```
