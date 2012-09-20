# Hystorical

Hystorical is a simple solution for managing historical datasets. Hystorical takes care of determining which objects are currently active or active on a particular day. It makes the following assumptions:

* Objects in the collection have `start_date` and `end_date` attributes
* `start_date` and `end_date` return a ruby `Date` object
* Typically members of the collection will be objects or hashes, but anything that implements start_date and end_date via `[]` or `.` can be used.
* Current objects have a `nil` end_date

## Installation

Add this line to your application's Gemfile:

    gem 'hystorical'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hystorical

## Usage

### current
Hystorical returns the current objects which is determined as objects with a end_date that returns `nil`
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
subscription1 = Subscription.new(Date.new(2012, 9, 1), Date.new(2012, 9, 10))
subscription2 = Subscription.new(Date.new(2012, 9, 11), nil)
subscriptions = [subscription1, subscription2]

Hystorical.current(subscriptions)
# => returns [subscription2]

date = Date.new(2012, 09, 8)
Hystorical.current_on(subscriptions, date)
# => returns [subscription1]
```

### Using Rails

Hystorical accepts ActiveRecord::Relation collections. This means that all your scopes integrate fully with Hystorical. In order to be optimized for larger datasets, Hystorical takes advantage of ActiveRecord::Relation methods to build a SQL query instead of using Enumerable methods when pass an instance of ActiveRecordRelation.

In a model
```ruby
class Subscription < ActiveRecord::Base
  attr_accessible :user_id, :start_date, :end_date

  def self.for_user(user_id)
    where user_id: user_id
  end

  def self.user_subscription_count_on(user_id, date)
    subscriptions = Subscription.for_user(user_id)
    Hystorical.current(subscriptions, date).count
  end

  def archive
    update_attributes { end_date: Date.today }
  end

end
```

In a controller
```ruby
def index
  @users_current_subscriptions = Hystorical.current Subscription.for_user(params[:user_id])
end
```

### Generator
Hystorical comes with a generator that creates a migration to add `start_date` and `end_date` to the specified model.

```
$ rails g hystorical:dates Subscription
$    create  db/migrate/20120917150948_add_start_date_end_date_to_subscriptions.rb
```

## Filtering

You can filter a dataset by passing in a block. This work's similarly to Enumerable's `select` method.

```ruby
Hystorical.current(subscriptions) do |subscription|
  subscription.type == :gold
end
```

## Philosophy
This gem was created using TDD and README-driven development. The architecture was designed with a strong focus on modularity and extensibility. Using ruby's `Enumerable` methods to return current object was chosen because of it's great flexibility to adapt to all ruby projects. However, when working with large datasets stored in a relational database, using SQL would yield greater performance. An adapter was added for ActiveRecord, but extending this to another ORM (such as DataMapper or Mongoid) is as simple as creating a new class that defines all the methods in the public api and adding a conditional in `Hystorical.delegate_class`.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
