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

Hystorical acts as a decorator to your models. You pass in your model into the constructor and can then call Hystorical's methods on it.
```ruby
hystorical_entries = Hystorical.new(Entry)
```

### current
Hystorical returns the current item(s)
```ruby
hystorical_entries = Hystorical.new(Entry)
current_entries = hystorical_entries.current
# => returns current item(s)
```

### current_at

Hystorical allows you to find which entries were current at a particular point in time.

```ruby
hystorical_entries = Hystorical.new(Entry)
current_entries_on_jan_10 = hystorical_entries.current_at(Date.new(2012, 01, 10))
# => returns item(s) that were current on January 10th
```

### archive
Archiving an item sets its `end_date` to today. The item is no longer current.
```ruby
hystorical_entries = Hystorical.new(Entry)
hystorical_entries.current.each do |entry|
  entry.archive
end
# => archives every current entry in the system
```

### archive_or_delete

Sometimes you expect a lot of changes to happen but don't really care about the intermediate states. For example:

```
Entry1 order: 1, start_date: "2012-06-01", end_date: "2012-09-12" # original state
Entry2 order: 3 start_date: "2012-09-12", end_date: "2012-09-12" # intermediate state
Entry3 order: 2 start_date: "2012-09-12", end_date: "2012-09-12" # intermediate state
Entry4 order: 4 start_date: "2012-09-12", end_date: nil # final state
```

In this example, the user has changed the order several times on the same day as he re-ordered his entries. I don't care about the intermediate states, only what the state was before and after the change. The intermediate states just clutter up my results and I would rather just get rid of them. `archive_or_delete` does just that. It will delete entries that would have the same start and end dates and archives those that do not.

```ruby
hystorical_entries = Hystorical.new(Entry)
hystorical_entries.current.each do |entry|
  entry.archive
end
# => if entry's start_date is today, it will be deleted. Otherwise it is archived
```

### Other methods
What about other methods you have defined on your object? Since Hystorical is just a decorator, you can use all the methods that were available to your original object.

```ruby
hystorical_entries = Hystorical.new(Entry)
hystorical_entries.custom_class_method # class methods work

curent_entry = hystorical_entries.current.first
current_entry.custom_instance_method # instance methods work
```



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
