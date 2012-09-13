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

Hystorical allows you to find which objects were current at a particular point in time.

```ruby
date = Date.new(2012, 01, 10)
Hystorical.current_on(@subscriptions, date)
# => returns enumerable collection of objects that were current on January 10th
```


## Examples

### Pure Ruby

```ruby
Subscription = Struct.new(:start_date, :end_date)
subscriptions = # collection of several Subscription objects

Hystorical.current(subscriptions)
# => returns enumerable collection of objects

date = Date.new(2012, 01, 10)
Hystorical.current_on(subscriptions, date)
# => returns enumerable collection of objects that were current on January 10th
```

### Using Rails

Hystorical accepts ActiveRecord::Relation collections. This means that all your scopes integrate fully with Hystorical.

In a model
```ruby
class Subscription < ActiveRecord::Base
  attr_accessible :user_id, :start_date, :end_date

  def self.for_user(user_id)
    where user_id: user_id
  end

  def self.user_subscription_count_on(user_id, date)
    subscriptions = Subscription.for_user(user_id)
    Hystorical.current subscriptions, date
  end

end
```

In a controller
```ruby
def index
  @users_current_subscriptions = Hystorical.current Subscription.for_user(params[:user_id])
end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
