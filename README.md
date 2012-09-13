# Hystorical

Hystorical is a simple solution for managing explicit historical datasets. Provided that your records have a `start_date` and `end_date`, Hystorical will take care figuring which records are currently active, which were active during a particular date range and managing the archiving of records. It makes the following assumptions:

* Objects in the collection have `start_date` and `end_date` attributes
* `start_date` and `end_date` return a ruby `Date` object
* the start and end dates can be accessed via either `[]` method or the `.` operator

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

## Philosophy
This gem was created using TDD and README-driven development. The architecture was designed with a strong focus on modularity and extensibility. Using ruby's `Enumerable` methods to return current object was chosen because of it's great flexibility to adapt to all ruby projects. However, when working with large datasets stored in a relational database, using SQL would yield greater performance. Adding an adapter for ActiveRecord or any other ORM (such as DataMapper or Mongoid) is as simple as creating a new class that defines all the methods in the public api and adding a conditional in `Hystorical.delegate_class`.

## TODO
 * Add ability to search via SQL when passed `ActiveRecord::Relation`
 * Add ability to pass in a block option that can further filter results

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
