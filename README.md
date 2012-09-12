# Hystorical

Hystorical is a simple solution for managing explicit historical datasets. Provided that your records have a `start_date` and `end_date`, Hystorical will take care figuring which records are currently active, which were active during a particular date range and managing the archiving of records.

## Installation

Add this line to your application's Gemfile:

    gem 'hystorical'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hystorical


## Usage

### current
Hystorical returns the current object which is determined as those with `nil` end_date
```ruby
Hystorical.current(@subscriptions)
# => returns enumerable collection of objects
```

### current_on

Hystorical allows you to find which entries were current at a particular point in time.

```ruby
date = Date.new(2012, 01, 10)
hystorical_entries = Hystorical.current_on(@subscriptions, date)
# => returns enumerable collection of objects that were current on January 10th
```


## Examples

### Pure Ruby

### Using Rails
```ruby
subscriptions = Hystorical.current_on(@user.subscriptions, Jan 10)
subscriptions.current
subscriptions.current_on(Jan 10)
current_subscriptions = Hystorical.new(@subscriptions, user_id: 1)
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
