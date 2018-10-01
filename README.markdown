# DynamizeFactories

Change static values in factories to dynamic by enclosing them in curly braces

# Problem

Since `factory_bot` 4.11, static attributes have been deprecated. Instead they should be passed in blocks.

So instead of

    factory :robot do
      name "Ralph"
    end

New way to use attribute-value pairs is:

    factory :robot do
      name {"Ralph"}
    end

Further: https://robots.thoughtbot.com/deprecating-static-attributes-in-factory_bot-4-11

## Usage

    ./run <File/Directory>
